local spawn     = require("awful.spawn")
local wibox     = require("wibox")
local paths     = require("constants.paths")
local beautiful = require("beautiful")

local brightness = {}
local textbox = wibox.widget.textbox()

local lain      = require("lain")
local markup = lain.util.markup

local icons = {
    low = " ",
    mid = " ",
    high = " ",
}

-- local icons = {
--     low = " ",
--     mid = " ",
--     high = " ",
-- }

brightness.widget = wibox.widget {
    textbox,
    layout = wibox.layout.align.horizontal
}

local brightness_script = paths.scripts .. "/brightness.bash"
local step = 5

local GET_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -get '
local SET_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -set '
local INC_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -inc ' .. step
local DEC_BRIGHTNESS_CMD= 'sudo ' .. brightness_script .. ' -dec ' .. step


local function update(value)
    value = math.ceil(value)
    if value <= 25 then
        textbox:set_markup(markup.font(beautiful.taglist_font, icons.low .. value))
    elseif value <= 75 then
        textbox:set_markup(markup.font(beautiful.taglist_font, icons.mid .. value))
    else
        textbox:set_markup(markup.font(beautiful.taglist_font, icons.high .. value))
    end
end

function brightness:inc()
    spawn.easy_async_with_shell(INC_BRIGHTNESS_CMD, update)
end

function brightness:dec()
    spawn.easy_async_with_shell(DEC_BRIGHTNESS_CMD, update)
end

spawn.easy_async_with_shell(GET_BRIGHTNESS_CMD, update)
return brightness
