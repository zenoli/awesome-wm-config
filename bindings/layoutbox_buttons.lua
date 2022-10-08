local gears = require "gears"
local awful = require "awful"
local gears_table = gears.table

local layoutbox_buttons = gears_table.join(
    awful.button({}, 1, function () awful.layout.inc( 1) end),
    awful.button({}, 2, function () awful.layout.set(awful.layout.layouts[1]) end),
    awful.button({}, 3, function () awful.layout.inc(-1) end),
    awful.button({}, 4, function () awful.layout.inc( 1) end),
    awful.button({}, 5, function () awful.layout.inc(-1) end)
)

return layoutbox_buttons
