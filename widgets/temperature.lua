local lain      = require("lain")
local wibox     = require("wibox")
local icons     = require("constants.icon_paths")
local beautiful = require("beautiful")

local markup = lain.util.markup

local icon = wibox.widget.imagebox(icons.temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, " " .. coretemp_now .. "°C "))
    end
})

local temperature = {
    widget = wibox.widget {
        icon,
        temp.widget,
        layout = wibox.layout.align.horizontal
    }
}
return temperature
