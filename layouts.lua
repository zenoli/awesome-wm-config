local awful = require("awful")
local l = awful.layout.suit

local layouts = {
    l.floating,
    l.tile,
    l.magnifier,
    l.tile.top,
    l.fair,
    l.max
}

return layouts
