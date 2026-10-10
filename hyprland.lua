local active_border_color = { colors = { "rgba(FF000080)", "rgba(F00F404d)" }, angle = 315 }
local inactive_border_color = { colors = { "rgba(42005c1a)", "rgba(00000080)" }, angle = 315 }

hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 6,
    border_size = 3,
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },

  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },

  decoration = {
    rounding = 13,
    shadow = {
      enabled = true,
      range = 5,
      render_power = 5,
      color = "rgba(eb000044)",
      offset = { 1, 2 },
    },
  },

  misc = {
    animate_manual_resizes = true,
    animate_mouse_windowdragging = true,
    enable_swallow = true,
  },
})

hl.curve("shutter", { type = "bezier", points = { { 0.85, 0.0 }, { 0.90, 1.0 } } })
hl.animation({ leaf = "border", enabled = true, speed = 20, bezier = "easeOutQuint" })
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 0.1667, bezier = "linear", style = "popin 90%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 0.25, bezier = "shutter" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 0.1667, bezier = "linear", style = "popin 88%" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 0.25, bezier = "shutter" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.667, bezier = "linear", style = "slidefade 12%" })
