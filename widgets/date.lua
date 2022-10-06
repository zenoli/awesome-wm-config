local wibox = require("wibox")
local lain      = require("lain")
local beautiful = require "beautiful"

local markup = lain.util.markup
local date =  wibox.widget.textclock(markup.font(beautiful.taglist_font, " %a %b %d"))

return  { widget = date }
