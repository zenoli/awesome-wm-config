local wibox = require("wibox")
local lain      = require("lain")
local beautiful = require "beautiful"

local markup = lain.util.markup
local clk = wibox.widget.textclock(markup.font(beautiful.taglist_font, " %H:%M"))

return { widget = clk }
