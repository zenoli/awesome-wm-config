local lain = require "lain"
local wibox = require "wibox"
local icons = require "constants.icon_paths"
local beautiful = require "beautiful"

local markup = lain.util.markup

local icon = wibox.widget.imagebox(icons.cpu)
local lain_cpu = lain.widget.cpu {
    settings = function() widget:set_markup(markup.font(beautiful.font, " " .. cpu_now.usage .. "% ")) end,
}
local cpu = {
    widget = wibox.widget {
        icon,
        lain_cpu.widget,
        layout = wibox.layout.align.horizontal,
    },
}
return cpu
