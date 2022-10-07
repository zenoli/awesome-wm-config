local wibox = require "wibox"
local lain = require "lain"
local beautiful = require "beautiful"
local markup = lain.util.markup

local icon_widget = wibox.widget.textbox(markup.font(beautiful.taglist_font, " "))
local clk = wibox.widget.textclock(markup.font(beautiful.font, "%H:%M"))

return {
    widget = {
        icon_widget,
        clk,
        layout = wibox.layout.fixed.horizontal,
    },
}
