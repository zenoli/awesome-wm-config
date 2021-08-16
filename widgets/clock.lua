local wibox = require("wibox")
local beautiful = require("beautiful")
local lain      = require("lain")
local markup = lain.util.markup
local colors = require("constants.colors")
local icons = require("constants.icon_paths")
local paths = require("constants.paths")

local icon = wibox.widget.imagebox(icons.time)

-- local clk = wibox.widget.textclock("%H:%M")
local clk = wibox.widget.textclock()
-- clk:set_markup(markup.fontfg(beautiful.font, colors.darkgrey))

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
