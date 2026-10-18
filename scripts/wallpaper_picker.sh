#!/usr/bin/env bash
WALL_DIR="$HOME/Pictures/Wallpapers"

# Запускаем демон swww, если он еще не запущен
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 0.5
fi

# Получаем список обоев
SELECTED=$(find "$WALL_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) -exec basename {} \; | rofi -dmenu -p "WALLPAPER" -config ~/.config/rofi/config.rasi)

if [ -n "$SELECTED" ]; then
    TARGET="$WALL_DIR/$SELECTED"
    # Кинематографичный переход волной на 120 FPS
    swww img "$TARGET" \
        --transition-type wave \
        --transition-angle 30 \
        --transition-step 90 \
        --transition-fps 120
    
    notify-send -u low -t 1500 "Wallpaper" "Обои обновлены: $SELECTED"
fi
