local spawn     = require("awful.spawn")
local wibox     = require("wibox")
local icons     = require("constants.icon_paths")
local paths     = require("constants.paths")
local beautiful = require("beautiful")

local brightness = {}
local icon = wibox.widget.imagebox(icons.brightness)
local textbox = wibox.widget.textbox()

local lain      = require("lain")
local markup = lain.util.markup

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

-- local brightness_script = '/home/olivier/.config/zsh/scripts/adjust_brightness.bash'
local brightness_script = paths.scripts .. "/brightness.bash"
local step = 5

local GET_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -get '
local SET_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -set '
local INC_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -inc ' .. step
local DEC_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -dec ' .. step


local function update(value)
    textbox:set_markup(markup.font(beautiful.font, " " .. math.ceil(value)))
end

function brightness:inc()
    spawn.easy_async_with_shell(INC_BRIGHTNESS_CMD, update)
end

function brightness:dec()
    spawn.easy_async_with_shell(DEC_BRIGHTNESS_CMD, update)
end

spawn.easy_async_with_shell(GET_BRIGHTNESS_CMD, update)
return brightness
