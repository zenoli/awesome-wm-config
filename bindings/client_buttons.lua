local gears             = require("gears")
local gears_table       = gears.table
local awful             = require("awful")
                          require("awful.autofocus")
-- local misc_constants    = require("/home/olivier/.config/awesome/constants/")
local const    = require("constants.misc")

local client_buttons = gears_table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ const.modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ const.altkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

return client_buttons
