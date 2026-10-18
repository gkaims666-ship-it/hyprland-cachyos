-- ==============================================================
-- Pure Obsidian Glass & Holographic Prism (Core Hyprland Theme)
-- ==============================================================

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 14,
        border_size = 2,
        extend_border_grab_area = 20,
        resize_on_border = true,
        hover_icon_on_border = true,
        layout = "dwindle",
        col = {
            -- Вращающийся призматический спектр (Циан -> Фиолет -> Розовый)
            active_border = {
                colors = { "rgba(00f5ffee)", "rgba(8a2be2ee)", "rgba(ff007fee)" },
                angle = 45,
            },
            inactive_border = "rgba(18192688)",
        },
    },

    decoration = {
        rounding = 16,
        active_opacity = 1.0,
        inactive_opacity = 0.88,
        dim_inactive = true,
        dim_strength = 0.15,
        dim_special = 0.35,

        -- Рассеянное неоновое свечение (Bloom)
        shadow = {
            enabled = true,
            range = 28,
            render_power = 4,
            color = "rgba(00f5ff33)",
            color_inactive = "rgba(00000055)",
        },

        -- Плотный кинематографичный матовый блюр
        blur = {
            enabled = true,
            size = 7,
            passes = 4,
            new_optimizations = true,
            xray = false,
            noise = 0.015,
            contrast = 1.05,
            brightness = 0.88,
            vibrancy = 0.35,
        },
    },

    dwindle = {
        preserve_split = true,
        smart_resizing = true,
        special_scale_factor = 0.88,
    },

    -- Неоновые вкладки сгруппированных окон
    group = {
        col = {
            border_active = "rgba(00f5ffee)",
            border_inactive = "rgba(181926aa)",
        },
        groupbar = {
            enabled = true,
            font_family = "JetBrainsMono Nerd Font",
            font_size = 10,
            height = 20,
            priority = 3,
            render_titles = true,
            scrolling = true,
            text_color = "rgba(cdd6f4ff)",
            col = {
                active = "rgba(00f5ffcc)",
                inactive = "rgba(1e1e2eaa)",
            },
        },
    },
})
