-- ==============================================================
-- Obsidian Glass & Advanced Hyprland Layout Aesthetics
-- ==============================================================

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        extend_border_grab_area = 20,
        resize_on_border = true,
        hover_icon_on_border = true,
        layout = "dwindle",
        col = {
            -- Спектральный призматический градиент активного окна
            active_border = {
                colors = { "rgba(00f5ffee)", "rgba(8a2be2ee)", "rgba(ff007fee)" },
                angle = 45,
            },
            inactive_border = "rgba(18192666)",
        },
    },

    decoration = {
        rounding = 12,
        active_opacity = 1.0,
        inactive_opacity = 0.92,
        dim_inactive = true,
        dim_strength = 0.08,
        dim_special = 0.25,

        -- Неоновый ореол (Bloom) вокруг активного окна
        shadow = {
            enabled = true,
            range = 22,
            render_power = 3,
            color = "rgba(00f5ff26)",
            color_inactive = "rgba(00000033)",
        },

        -- Качественный Dual-Kawase blur
        blur = {
            enabled = true,
            size = 6,
            passes = 3,
            new_optimizations = true,
            xray = false,
            noise = 0.015,
            contrast = 0.95,
            brightness = 0.85,
            vibrancy = 0.25,
        },
    },

    -- Плавное и умное тайлинг-древо
    dwindle = {
        preserve_split = true,
        smart_resizing = true,
        special_scale_factor = 0.88,
    },

    -- Стилизация вкладок (Grouped Windows)
    group = {
        col = {
            border_active = "rgba(00f5ffee)",
            border_inactive = "rgba(18192688)",
        },
        groupbar = {
            enabled = true,
            font_family = "JetBrainsMono Nerd Font",
            font_size = 10,
            height = 18,
            priority = 3,
            render_titles = true,
            scrolling = true,
            text_color = "rgba(cdd6f4ff)",
            col = {
                active = "rgba(00f5ffaa)",
                inactive = "rgba(1e1e2eaa)",
            },
        },
    },

    -- Анимация перетаскивания и ресайза окон
    misc = {
        animate_manual_resizes = true,
        animate_mouse_windowdragging = true,
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        focus_on_activate = true,
        new_window_takes_over_fullscreen = 2,
    },
})
