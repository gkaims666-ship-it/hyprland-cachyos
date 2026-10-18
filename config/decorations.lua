-- ==============================================================
-- Unixporn Glassmorphism & Visual Aesthetics
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
            active_border = {
                colors = { "rgba(cba6f7ee)", "rgba(89b4faee)", "rgba(f38ba8ee)" },
                angle = 45,
            },
            inactive_border = "rgba(31324466)",
        },
    },

    decoration = {
        rounding = 12,
        active_opacity = 1.0,
        inactive_opacity = 0.94,
        dim_inactive = true,
        dim_strength = 0.1,

        shadow = {
            enabled = true,
            range = 25,
            render_power = 3,
            color = "rgba(00000055)",
            color_inactive = "rgba(00000025)",
        },

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
