local spawn = require "awful.spawn"
local wibox = require "wibox"
local paths = require "constants.paths"
local beautiful = require "beautiful"

local brightness = {}

local lain = require "lain"
local markup = lain.util.markup

local text_widget = wibox.widget.textbox()
local icon_widget = wibox.widget.textbox()

local icons = {
    low = "󰃞 ",
    mid = "󰃟 ",
    high = "󰃠 ",
}

-- local icons = {
--     low = " ",
--     mid = " ",
--     high = " ",
-- }

brightness.widget = wibox.widget {
    icon_widget,
    text_widget,
    layout = wibox.layout.fixed.horizontal,
}

local brightness_script = paths.scripts .. "/brightness.bash"
local step = 5

local GET_BRIGHTNESS_CMD = "sudo " .. brightness_script .. " -get "
local SET_BRIGHTNESS_CMD = "sudo " .. brightness_script .. " -set "
local INC_BRIGHTNESS_CMD = "sudo " .. brightness_script .. " -inc " .. step
local DEC_BRIGHTNESS_CMD = "sudo " .. brightness_script .. " -dec " .. step

local function update(value)
    local function update_icon(icon)
        icon_widget:set_markup(markup.font(beautiful.taglist_font, icon))
        text_widget:set_markup(markup.font(beautiful.font, value))
    end
    value = math.ceil(value)
    if value <= 25 then
        update_icon(icons.low)
    elseif value <= 75 then
        update_icon(icons.mid)
    else
        update_icon(icons.high)
    end
end

function brightness:inc() spawn.easy_async_with_shell(INC_BRIGHTNESS_CMD, update) end

function brightness:dec() spawn.easy_async_with_shell(DEC_BRIGHTNESS_CMD, update) end

spawn.easy_async_with_shell(GET_BRIGHTNESS_CMD, update)
return brightness
