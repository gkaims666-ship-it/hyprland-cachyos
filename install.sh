#!/usr/bin/env bash
set -e
echo "==> Установка конфигурации Hyprland CachyOS..."
mkdir -p ~/.config/systemd/user ~/.config/hypr
cp -r . ~/.config/hypr/
cp systemd/hypr-audio-router.service ~/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user enable --now hypr-audio-router.service
hyprctl reload
echo "=== Установка завершена: все настройки и звук активны! ==="
