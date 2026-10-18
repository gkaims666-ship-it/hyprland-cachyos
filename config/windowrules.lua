-- ==============================================================
-- Glassmorphism Transparency & Layer Blur Rules
-- ==============================================================

-- Аппаратный блюр под всеми стеклянными панелями и всплывающими меню
hl.layer_rule({
    match = { namespace = "^(waybar|rofi|swayosd|swappy|launcher|notifications)$" },
    blur = true,
    blur_popups = true,
    ignore_alpha = 0.2,
})

-- Легкая прозрачность для терминала и файловых менеджеров
hl.window_rule({ match = { class = "^(kitty|Alacritty|foot)$" }, opacity = 0.82 })
hl.window_rule({ match = { class = "^(dolphin|thunar|org.gnome.Nautilus)$" }, opacity = 0.90 })

-- Видео, игры и браузеры сохраняют сочные цвета
hl.window_rule({ match = { class = "^(mpv|vlc|steam_app.*|gamescope)$" }, opaque = true })

-- Окна выбора файлов и диалоги
hl.window_rule({ match = { title = "^(Open File|Save File|Выбор файла|Сохранить файл|Open Folder)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol)$" }, float = true, center = true })

-- Wlogout Layer Blur --
hl.layer_rule({
    match = { namespace = "^(wlogout)$" },
    blur = true,
    blur_popups = true,
    ignore_alpha = 0.1,
})
-- End Wlogout Layer Blur --
