local gears       = require("gears")
local awful       = require("awful")
local gears_table = gears.table

local tasklist_buttons = gears_table.join(
    awful.button(
        { }, 1,
        function(c)
            if c == client.focus then
                c.minimized = true
            else
                c:emit_signal("request::activate", "tasklist", { raise = true })
            end
        end
    ),
    awful.button(
        { }, 3,
        function()
            awful.menu.client_list({ theme = { width = 250 } })
        end
    )
)

return tasklist_buttons
