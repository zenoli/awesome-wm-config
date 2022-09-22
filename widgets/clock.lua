local wibox = require("wibox")
local icons = require("constants.icon_paths")

local icon = wibox.widget.imagebox(icons.time)

local clk = wibox.widget.textclock()

local clock = {
    widget = wibox.widget {
        {
            icon,
            left   = 0,
            right  = 4,
            top    = 3,
            bottom = 3,
            layout = wibox.container.margin
        },
        clk,
        layout = wibox.layout.align.horizontal
    }
}
return clock
