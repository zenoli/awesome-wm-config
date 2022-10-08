local gears = require "gears"
local awful = require "awful"
local keys = require "constants.keys"
local gears_table = gears.table

local client_buttons = gears_table.join(
    awful.button(
        { }, 1,
        function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
        end
    ),
    awful.button(
        { keys.mod }, 1,
        function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        { keys.alt }, 1,
        function (c)
            c:emit_signal("request::activate", "mouse_click", {raise = true})
            awful.mouse.client.resize(c)
        end
    )
)

return client_buttons
