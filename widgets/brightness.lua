local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local wibox     = require("wibox")
local icons     = require("constants.icon_paths")

local brightness = {}
local icon = wibox.widget.imagebox(icons.brightness)
local textbox = wibox.widget.textbox()

-- brightness.widget = brightness_widget{
--     type = 'icon_and_text',
--     program = 'custom',
--     base = 80,
--     step = 5,
--     tooltip = false
-- }
brightness.widget = wibox.widget {
    {
        icon,
        left   = 0,
        right  = 0,
        top    = 2,
        bottom = 2,
        layout = wibox.container.margin
    },
    textbox,
    layout = wibox.layout.align.horizontal
}

local brightness_script = '/home/olivier/.config/zsh/scripts/adjust_brightness.bash'
local step = 5

local GET_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -get '
local SET_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -set '
local INC_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -inc ' .. step
local DEC_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -dec ' .. step


function update()
    return
end

function brightness:inc()
    spawn.easy_async_with_shell(INC_BRIGHTNESS_CMD, alsa.update)
end

function brightness:dec()
    spawn.easy_async_with_shell(DEC_BRIGHTNESS_CMD, alsa.update)
end
return brightness
