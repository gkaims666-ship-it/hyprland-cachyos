-- ==============================================================
-- Fluid Physics & Unixporn Bezier Curves
-- ==============================================================

hl.config({
    animations = {
        enabled = true,
    },
})

-- Фирменные кривые с r/unixporn (End-4 & Hyprdots)
hl.curve("wind", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.1 }, { 0.1, 1.1 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.3, -0.3 }, { 0, 1 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("liner", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })

-- Привязка анимаций
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "wind", style = "slide" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4, bezier = "winIn", style = "popin 80%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "winOut", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "wind", style = "slide" })

-- Вращающийся неоновый градиент рамки
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 30, bezier = "liner", style = "loop" })

-- Затухание и рабочие столы
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "easeInOutCubic" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "wind", style = "slide" })
