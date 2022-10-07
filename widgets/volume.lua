local lain = require "lain"
local wibox = require "wibox"
local spawn = require "awful.spawn"
local beautiful = require "beautiful"

local markup = lain.util.markup

local icons = {
    mute = "婢",
    low = "奄",
    mid = "奔",
    high = "墳",
}

local text_widget = wibox.widget.textbox()
local icon_widget = wibox.widget.textbox()

local alsa = lain.widget.alsa {
    cmd = "amixer -D pulse",
    timeout = 1,
    settings = function()
        local function update_icon(icon)
            icon_widget:set_markup(markup.font(beautiful.taglist_font, icon .. " "))
            text_widget:set_markup(markup.font(beautiful.font, volume_now.level))
        end
        update_icon(icons.high)
        local perc = tonumber(volume_now.level) or 0

        if volume_now.status == "off" then
            update_icon(icons.mute)
        else
            if perc <= 25 then
                update_icon(icons.low)
            elseif perc <= 50 then
                update_icon(icons.mid)
            else
                update_icon(icons.high)
            end
        end
    end,
}

local GET_VOLUME_CMD = 'amixer -D pulse sget Master'
local INC_VOLUME_CMD = 'amixer -D pulse sset Master 5%+'
local DEC_VOLUME_CMD = 'amixer -D pulse sset Master 5%-'
local TOG_VOLUME_CMD = 'amixer -D pulse sset Master toggle'

local volume = {
    widget = {
        icon_widget,
        text_widget,
        layout = wibox.layout.fixed.horizontal
    }
}

function volume:inc()
    spawn.easy_async_with_shell(INC_VOLUME_CMD, alsa.update)
end

function volume:dec()
    spawn.easy_async_with_shell(DEC_VOLUME_CMD, alsa.update)
end

function volume:toggle()
    spawn.easy_async_with_shell(TOG_VOLUME_CMD, alsa.update)
end

-- volume.widget = alsa.widget

return volume
