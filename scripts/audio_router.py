#!/usr/bin/env python3
import json
import subprocess
import time
import threading

def run_cmd(cmd):
    try:
        res = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True)
        return res.stdout.strip()
    except Exception:
        return ""

def get_ancestors(pid):
    ancestors = set()
    curr = pid
    while curr > 1:
        ancestors.add(curr)
        try:
            with open(f"/proc/{curr}/stat", "r") as f:
                stat = f.read().split()
                curr = int(stat[3])
        except Exception:
            break
    return ancestors

def get_sinks():
    out = run_cmd(["pactl", "-f", "json", "list", "sinks"])
    if not out:
        return None, None
    try:
        sinks = json.loads(out)
    except Exception:
        return None, None

    hdmi_sink = None
    speaker_sink = None

    for s in sinks:
        name = s.get("name", "")
        desc = s.get("description", "").lower()
        name_lower = name.lower()

        if "analog-stereo" in name_lower or "speaker" in desc:
            speaker_sink = name
        elif "hdmi" in name_lower or "hdmi" in desc:
            hdmi_sink = name

    if not speaker_sink:
        for s in sinks:
            if "hdmi" not in s.get("name", "").lower():
                speaker_sink = s.get("name")
                break

    if not hdmi_sink:
        for s in sinks:
            if "hdmi" in s.get("name", "").lower():
                hdmi_sink = s.get("name")
                break

    return speaker_sink, hdmi_sink

# Глобальный кэш привязки конкретного аудиопотока (sink-input ID) к рабочему столу
stream_assignment = {}

def sync_audio_parallel():
    speaker_sink, hdmi_sink = get_sinks()
    if not speaker_sink or not hdmi_sink:
        return

    # 1. Получаем список мониторов и рабочих столов
    out_mon = run_cmd(["hyprctl", "monitors", "-j"])
    if not out_mon:
        return
    try:
        monitors = json.loads(out_mon)
    except Exception:
        return

    tv_mon_names = set()
    for m in monitors:
        name = m.get("name", "")
        if "edp" not in name.lower():
            tv_mon_names.add(name)

    out_ws = run_cmd(["hyprctl", "workspaces", "-j"])
    ws_to_mon = {}
    if out_ws:
        try:
            for w in json.loads(out_ws):
                ws_to_mon[w.get("id")] = w.get("monitor", "")
        except Exception:
            pass

    # 2. Получаем все окна и их рабочие столы
    out_clients = run_cmd(["hyprctl", "clients", "-j"])
    if not out_clients:
        return
    try:
        clients = json.loads(out_clients)
    except Exception:
        return

    # Разделяем окна по зонам: окна на ТВ и окна на ноутбуке
    tv_clients = []
    laptop_clients = []

    for c in clients:
        ws_id = c.get("workspace", {}).get("id")
        target_mon = ws_to_mon.get(ws_id, c.get("monitor", ""))
        at = c.get("at", [0, 0])
        is_tv = (target_mon in tv_mon_names) or (len(at) >= 2 and at[1] < 0)
        if is_tv:
            tv_clients.append(c)
        else:
            laptop_clients.append(c)

    # 3. Получаем активные аудиопотоки
    out_si = run_cmd(["pactl", "-f", "json", "list", "sink-inputs"])
    if not out_si:
        return
    try:
        sink_inputs = json.loads(out_si)
    except Exception:
        return

    out_s = run_cmd(["pactl", "-f", "json", "list", "sinks"])
    out_sinks_map = {}
    if out_s:
        try:
            for s in json.loads(out_s):
                out_sinks_map[s.get("index")] = s.get("name")
        except Exception:
            pass

    current_si_ids = set()

    # Сортируем потоки по ID
    for si in sorted(sink_inputs, key=lambda x: x.get("index", 0)):
        si_idx = si.get("index")
        current_si_ids.add(si_idx)
        props = si.get("properties", {})
        pid_str = props.get("application.process.id")
        if not pid_str:
            continue
        try:
            si_pid = int(pid_str)
        except ValueError:
            continue

        ancestors = get_ancestors(si_pid)

        # Проверяем, есть ли подходящие окна на ТВ и на ноутбуке
        matching_tv = [c for c in tv_clients if c.get("pid") == si_pid or c.get("pid") in ancestors]
        matching_laptop = [c for c in laptop_clients if c.get("pid") == si_pid or c.get("pid") in ancestors]

        target_sink = None

        # СЛУЧАЙ 1: Поток уже был ранее закреплен за монитором
        if si_idx in stream_assignment:
            target_sink = stream_assignment[si_idx]
        else:
            # СЛУЧАЙ 2: Новый поток запускается — определяем его рабочий стол
            # Если окна этого приложения есть ТОЛЬКО на ТВ
            if matching_tv and not matching_laptop:
                target_sink = hdmi_sink
            # Если окна есть ТОЛЬКО на ноутбуке
            elif matching_laptop and not matching_tv:
                target_sink = speaker_sink
            # Если окна одного и того же браузера открыты И на ТВ, И на ноутбуке:
            elif matching_tv and matching_laptop:
                # Проверяем уже существующие привязки:
                # Если на ТВ уже играет другой поток, этот новый поток отдаем ноутбуку!
                assigned_to_tv = sum(1 for s_id, s_dest in stream_assignment.items() if s_dest == hdmi_sink and s_id in current_si_ids)
                assigned_to_laptop = sum(1 for s_id, s_dest in stream_assignment.items() if s_dest == speaker_sink and s_id in current_si_ids)

                if assigned_to_tv > assigned_to_laptop:
                    target_sink = speaker_sink
                else:
                    target_sink = hdmi_sink
            else:
                target_sink = speaker_sink

            stream_assignment[si_idx] = target_sink

        # Перенаправляем индивидуальный поток
        curr_sink_name = out_sinks_map.get(si.get("sink"))
        if curr_sink_name != target_sink:
            run_cmd(["pactl", "move-sink-input", str(si_idx), target_sink])

    # Очищаем память от закрытых потоков
    for old_id in list(stream_assignment.keys()):
        if old_id not in current_si_ids:
            del stream_assignment[old_id]

def loop_sync():
    while True:
        try:
            sync_audio_parallel()
        except Exception:
            pass
        time.sleep(0.5)

if __name__ == "__main__":
    loop_sync()
