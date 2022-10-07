local awful = require "awful"
local wibox = require "wibox"
local beautiful = require "beautiful"
local keyboardlayout = awful.widget.keyboardlayout:new()

return {
    widget = {
        {
            text = " ",
            font = beautiful.taglist_font,
            widget = wibox.widget.textbox,
        },
        keyboardlayout,
        layout = wibox.layout.fixed.horizontal,
    },
}
