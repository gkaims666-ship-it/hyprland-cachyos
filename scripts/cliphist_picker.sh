#!/usr/bin/env bash
# Запуск поисковика истории буфера обмена через стилизованный Rofi
SELECTED=$(cliphist list | rofi -dmenu -p "CLIPBOARD" -config ~/.config/rofi/config.rasi)

if [ -n "$SELECTED" ]; then
    echo "$SELECTED" | cliphist decode | wl-copy
    notify-send -u low -t 1200 "Clipboard" "Скопировано в буфер обмена"
fi
