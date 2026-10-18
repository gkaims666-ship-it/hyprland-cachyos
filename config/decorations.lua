-- ==============================================================
-- Obsidian Glass & Holographic Prism Aesthetics
-- ==============================================================

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        extend_border_grab_area = 15,
        resize_on_border = true,
        layout = "dwindle",
        col = {
            -- Голографический спектр: Электрический Циан -> Фиолетовый -> Неоновый Розовый
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

        -- Неоновое рассеянное свечение (Bloom) вокруг активного окна
        shadow = {
            enabled = true,
            range = 22,
            render_power = 3,
            color = "rgba(00f5ff26)",
            color_inactive = "rgba(00000033)",
        },

        -- Глубокий Dual-Kawase блюр
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
})
