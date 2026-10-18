#!/usr/bin/env bash
SHADER_PATH="$HOME/.config/hypr/shaders/cinematic_lens.frag"

# Проверяем, включен ли шейдер сейчас
CURRENT=$(hyprctl getoption decoration:screen_shader -j 2>/dev/null | jq -r ".str" 2>/dev/null || echo "")

if [ -n "$CURRENT" ] && [ "$CURRENT" != "none" ] && [ "$CURRENT" != "[[Empty]]" ]; then
    hyprctl keyword decoration:screen_shader "" > /dev/null
    notify-send -u low -t 1500 "Shaders" "Кинематографичный шейдер отключен"
else
    hyprctl keyword decoration:screen_shader "$SHADER_PATH" > /dev/null
    notify-send -u low -t 1500 "Shaders" "Кинематографичный шейдер включен (0.1% GPU)"
fi
