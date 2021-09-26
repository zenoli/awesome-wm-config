local lain      = require("lain")
local wibox     = require("wibox")
local spawn     = require("awful.spawn")
local icons     = require("constants.icon_paths")
local beautiful = require("beautiful")
local p = require("constants.paths")

local markup = lain.util.markup
local icon = wibox.widget.imagebox(icons.volume.high)

local alsa = lain.widget.alsa({
    cmd = "amixer -D pulse",
    timeout = 1,
    settings = function()
        widget:set_markup(markup.font(beautiful.font, " " .. volume_now.level))
        local icon_path, perc = "", tonumber(volume_now.level) or 0

        if volume_now.status == "off" then
            icon_path = icons.volume.mute
        else
            if perc <= 5 then
                icon_path = icons.volume.off
            elseif perc <= 25 then
                icon_path = icons.volume.low
            elseif perc <= 75 then
                icon_path = icons.volume.medium
            else
                icon_path = icons.volume.high
            end
        end
        icon:set_image(icon_path)
    end
})

local GET_VOLUME_CMD = 'amixer -D pulse sget Master'
local INC_VOLUME_CMD = 'amixer -D pulse sset Master 5%+'
local DEC_VOLUME_CMD = 'amixer -D pulse sset Master 5%-'
local TOG_VOLUME_CMD = 'amixer -D pulse sset Master toggle'

local volume = {}

function volume:inc()
    spawn.easy_async_with_shell(INC_VOLUME_CMD, alsa.update)
end

function volume:dec()
    spawn.easy_async_with_shell(DEC_VOLUME_CMD, alsa.update)
end

function volume:toggle()
    spawn.easy_async_with_shell(TOG_VOLUME_CMD, alsa.update)
end

volume.widget = wibox.widget {
    {
        icon,
        left   = 0,
        right  = 0,
        top    = 2,
        bottom = 2,
        layout = wibox.container.margin
    },
    alsa.widget,
    layout = wibox.layout.align.horizontal
}

return volume
