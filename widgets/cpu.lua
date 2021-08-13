local lain  = require("lain")
local wibox = require("wibox")
local icons = require("constants.icon_paths")

local markup = lain.util.markup


local icon = wibox.widget.imagebox(icons.widgets.cpu)
local lain_cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font("Terminus 9", " " .. cpu_now.usage .. "% "))
    end
})
local cpu = {
    widget = wibox.widget {
        icon,
        lain_cpu.widget,
        layout = wibox.layout.align.horizontal
    }
}
return cpu
