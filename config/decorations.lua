-- ==============================================================
-- Pure Glassmorphism & Prism Optics (Hyprland Core)
-- ==============================================================

hl.config({
    general = {
        gaps_in = 6,
        gaps_out = 12,
        border_size = 2,
        extend_border_grab_area = 20,
        resize_on_border = true,
        hover_icon_on_border = true,
        layout = "dwindle",
        col = {
            -- Голографический спектр со стеклянным световым бликом
            active_border = {
                colors = { "rgba(00f5ffdd)", "rgba(ffffff55)", "rgba(ff007fdd)" },
                angle = 45,
            },
            inactive_border = "rgba(2552552518)",
        },
    },

    decoration = {
        rounding = 16,
        active_opacity = 0.96,
        inactive_opacity = 0.84,
        dim_inactive = true,
        dim_strength = 0.12,
        dim_special = 0.35,

        -- Рассеянная объёмная тень под стеклом
        shadow = {
            enabled = true,
            range = 30,
            render_power = 4,
            color = "rgba(00f5ff24)",
            color_inactive = "rgba(00000066)",
        },

        -- Усиленный 4-проходный Dual-Kawase blur (матовое стекло)
        blur = {
            enabled = true,
            size = 8,
            passes = 4,
            new_optimizations = true,
            xray = false,
            noise = 0.015,
            contrast = 1.1,
            brightness = 0.9,
            vibrancy = 0.4,
        },
    },

    dwindle = {
        preserve_split = true,
        smart_resizing = true,
        special_scale_factor = 0.88,
    },
})
