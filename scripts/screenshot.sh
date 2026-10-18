#!/usr/bin/env bash
mkdir -p "$HOME/Pictures/Screenshots"

case "$1" in
    "area")
        # Выделение с неоновой бирюзовой рамкой и затемнением задника
        GEOM=$(slurp -b "#0a0b10aa" -c "#00f5ff" -s "#00f5ff15" -w 2)
        if [ -n "$GEOM" ]; then
            grim -g "$GEOM" - | swappy -f -
        fi
        ;;
    "full")
        FILE="$HOME/Pictures/Screenshots/Screenshot_$(date +%Y%m%d_%H%M%S).png"
        grim "$FILE"
        wl-copy < "$FILE"
        notify-send -u low -t 1500 -i "$FILE" "Скриншот" "Сохранен в буфер и папку Screenshots"
        ;;
esac
