local lain      = require("lain")
local wibox     = require("wibox")
local icons     = require("constants.icon_paths")
local beautiful = require("beautiful")

local markup = lain.util.markup

local icon = wibox.widget.imagebox(icons.widgets.net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, "#FEFEFE", " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
    end
})

local network = {
    widget = wibox.widget {
        icon,
        net.widget,
        layout = wibox.layout.align.horizontal
    }
}
return network
