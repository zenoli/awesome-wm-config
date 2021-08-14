local lain  = require("lain")
local wibox = require("wibox")
local spawn = require("awful.spawn")
local icons = require("constants.icon_paths")
local beautiful = require("beautiful")

local markup = lain.util.markup
local icon = wibox.widget.imagebox(icons.widgets.vol)

local icon = wibox.widget.imagebox(icons.widgets.battery)
local bat = lain.widget.bat({
    timeout = 1,
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(beautiful.font, " AC "))
                icon:set_image(icons.widgets.ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                icon:set_image(icons.widgets.battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                icon:set_image(icons.widgets.battery_low)
            else
                icon:set_image(icons.widgets.battery)
            end
            widget:set_markup(markup.font(beautiful.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup()
            icon:set_image(icons.widgets.ac)
        end
    end
})

local battery = {
    widget = wibox.widget {
        icon,
        bat.widget,
        layout = wibox.layout.align.horizontal
    }
}

return battery
