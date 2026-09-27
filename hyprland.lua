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

-- Ghost candidate 09 — 06 family (shutter + horizontal slidefade), overlap clocks.
-- Do not overfit 60 Hz. Speeds from 75hz-best-overlap.md (shared 60/75/100/120/144).
--   tiles geo  16.667 ms = speed 0.1667  (1 frame @60, 2 @120) — near instant
--   tiles fade 25 ms     = speed 0.25    (2 frames @100, 3 @120) — shutter still has
--                          a dump on 100/120; on 60/75 it is ~1–2 paints (cut-soften)
--   SUPER+N    40 ms     = speed 0.40    (3 frames @75, 4 @100) — obvious but snappy
-- Spring strobe omitted: k=520 period ~276 ms cannot be 20 ms. Same curves otherwise.
-- Falsify: if open/close feel like a hard cut on 120/144, raise fade to 0.267 (26.7 ms).
-- If SUPER+N feels sluggish, cut toward 0.333 (33 ms) not back to 06's 2.2 (220 ms).
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
