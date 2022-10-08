local awful = require "awful"
local keys = require "constants.keys"
local gears = require "gears"
local gears_table = gears.table

local taglist_buttons = gears_table.join(
    awful.button(
        { }, 1,
        function(t) t:view_only() end
    ),
    awful.button(
        { keys.mod }, 1,
        function(t) if client.focus then client.focus:move_to_tag(t) end end
    ),
    awful.button(
        { }, 3,
        awful.tag.viewtoggle
    ),
    awful.button(
        { keys.alt }, 1,
        function(t) if client.focus then client.focus:toggle_tag(t) end end
    )
)

return taglist_buttons
