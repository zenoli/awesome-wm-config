local lain  = require("lain")
local wibox = require("wibox")
local spawn = require("awful.spawn")
local icons = require("constants.icon_paths")
local beautiful = require("beautiful")

local markup = lain.util.markup

local icon = wibox.widget.imagebox(icons.battery_high)
local bat = lain.widget.bat({
    timeout = 1,
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                if     tonumber(bat_now.perc) >= 95 then icon:set_image(icons.battery.fully_charged)
                elseif tonumber(bat_now.perc) >= 85 then icon:set_image(icons.battery.charging_90)
                elseif tonumber(bat_now.perc) >= 65 then icon:set_image(icons.battery.charging_80)
                elseif tonumber(bat_now.perc) >= 55 then icon:set_image(icons.battery.charging_60)
                elseif tonumber(bat_now.perc) >= 35 then icon:set_image(icons.battery.charging_50)
                elseif tonumber(bat_now.perc) >= 25 then icon:set_image(icons.battery.charging_30)
                elseif tonumber(bat_now.perc) >= 15 then icon:set_image(icons.battery.charging_20)
                elseif tonumber(bat_now.perc) >=  5 then icon:set_image(icons.battery.charging_10)
                else                                     icon:set_image(icons.battery.alert)
                end
            else
                if     tonumber(bat_now.perc) >= 95 then icon:set_image(icons.battery.discharging_100)
                elseif tonumber(bat_now.perc) >= 85 then icon:set_image(icons.battery.discharging_90)
                elseif tonumber(bat_now.perc) >= 65 then icon:set_image(icons.battery.discharging_80)
                elseif tonumber(bat_now.perc) >= 55 then icon:set_image(icons.battery.discharging_60)
                elseif tonumber(bat_now.perc) >= 35 then icon:set_image(icons.battery.discharging_50)
                elseif tonumber(bat_now.perc) >= 25 then icon:set_image(icons.battery.discharging_30)
                elseif tonumber(bat_now.perc) >= 15 then icon:set_image(icons.battery.discharging_20)
                else                                     icon:set_image(icons.battery.alert_red)
                end
                widget:set_markup(markup.font(beautiful.font, " " .. bat_now.perc .. "% "))
                return
                -- icon:set_image(icons.ac)
                -- return
            -- elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
            --     icon:set_image(icons.battery_empty)
            -- elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
            --     icon:set_image(icons.battery_low)
            -- else
            --     icon:set_image(icons.battery_high)
            end
            widget:set_markup(markup.font(beautiful.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup()
            icon:set_image(icons.ac)
        end
    end
})

local battery = {
    widget = wibox.widget {
        {
            icon,
            left   = 0,
            right  = 0,
            top    = 2,
            bottom = 2,
            layout = wibox.container.margin
        },
        bat.widget,
        layout = wibox.layout.align.horizontal
    }
}

return battery
