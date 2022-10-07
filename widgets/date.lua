local wibox = require("wibox")
local lain      = require("lain")
local beautiful = require "beautiful"
local markup = lain.util.markup

local icon_widget = wibox.widget.textbox(markup.font(beautiful.taglist_font," "))
local date =  wibox.widget.textclock(markup.font(beautiful.font, "%a %b %d"))

return {
    widget = {
        icon_widget,
        date,
        layout = wibox.layout.fixed.horizontal
    }
}
