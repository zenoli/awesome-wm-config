local lain = require "lain"
local wibox = require "wibox"
local beautiful = require "beautiful"

local markup = lain.util.markup

local text_widget = wibox.widget.textbox()
local icon_widget = wibox.widget.textbox()

local icons = {
    discharging_0 = "󰂎",
    discharging_10 = "󰁺 ",
    discharging_20 = "󰁻 ",
    discharging_30 = "󰁼 ",
    discharging_40 = "󰁽 ",
    discharging_50 = "󰁾 ",
    discharging_60 = "󰁿 ",
    discharging_70 = "󰂀 ",
    discharging_80 = "󰂁 ",
    discharging_90 = "󰂂 ",
    discharging_100 = "󰁹 ",

    charging_20 = "󰂆 ",
    charging_30 = "󰂇 ",
    charging_40 = "󰂈 ",
    charging_60 = "󰂉 ",
    charging_80 = "󰂊 ",
    charging_90 = "󰂋 ",
    charging_100 = "󰂅 ",
}

lain.widget.bat {
    timeout = 1,
    settings = function()
        local function update_icon(icon)
            icon_widget:set_markup(markup.font(beautiful.taglist_font, icon))
            text_widget:set_markup(markup.font(beautiful.font, bat_now.perc .. "%"))
        end
        -- stylua: ignore
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                if     tonumber(bat_now.perc) >= 95 then update_icon(icons.charging_100)
                elseif tonumber(bat_now.perc) >= 85 then update_icon(icons.charging_90)
                elseif tonumber(bat_now.perc) >= 65 then update_icon(icons.charging_80)
                elseif tonumber(bat_now.perc) >= 55 then update_icon(icons.charging_60)
                elseif tonumber(bat_now.perc) >= 35 then update_icon(icons.charging_40)
                elseif tonumber(bat_now.perc) >= 25 then update_icon(icons.charging_30)
                else                                     update_icon(icons.charging_20)
                end
            else
                if     tonumber(bat_now.perc) >= 95 then update_icon(icons.discharging_100)
                elseif tonumber(bat_now.perc) >= 85 then update_icon(icons.discharging_90)
                elseif tonumber(bat_now.perc) >= 65 then update_icon(icons.discharging_80)
                elseif tonumber(bat_now.perc) >= 55 then update_icon(icons.discharging_60)
                elseif tonumber(bat_now.perc) >= 35 then update_icon(icons.discharging_50)
                elseif tonumber(bat_now.perc) >= 25 then update_icon(icons.discharging_30)
                elseif tonumber(bat_now.perc) >= 15 then update_icon(icons.discharging_20)
                else                                     update_icon(icons.discharging_0)
                end
            end
        else
            widget:set_markup()
        end
    end,
}

local battery = {
    widget = {
        icon_widget,
        text_widget,
        layout = wibox.layout.fixed.horizontal,
    },
}

return battery
