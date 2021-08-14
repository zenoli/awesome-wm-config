local lain      = require("lain")
local wibox     = require("wibox")
local icons     = require("constants.icon_paths")
local beautiful = require("beautiful")

local markup = lain.util.markup

local icon = wibox.widget.imagebox(icons.widgets.mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, " " .. mem_now.used .. "MB "))
    end
})

local memory = {
    widget = wibox.widget {
        icon,
        mem.widget,
        layout = wibox.layout.align.horizontal
    }
}
return memory
