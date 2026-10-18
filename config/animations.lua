-- ==============================================================
-- Organic Spring Physics & Fluid Animations
-- ==============================================================

hl.config({
    animations = {
        enabled = true,
    },
})

-- Органичные кривые Безье с упругой пружиной
hl.curve("spring", { type = "bezier", points = { { 0.12, 1.15 }, { 0.25, 1.0 } } })
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("liner", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })

-- Анимация окон с пружинным открытием
hl.animation({ leaf = "windows", enabled = true, speed = 3.5, bezier = "spring", style = "popin 85%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.5, bezier = "spring", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3.5, bezier = "winOut", style = "popin 85%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.5, bezier = "wind", style = "slide" })

-- Бесконечный вращающийся неоновый градиент рамки
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 25, bezier = "liner", style = "loop" })

-- Плавное затухание и кинематографичный сдвиг столов
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "easeInOutCubic" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "wind", style = "slide" })
