local awful = require "awful"
local wibox = require "wibox"
local gears = require "gears"
local tasklist_buttons = require "bindings.tasklist_buttons"
local colors = require "constants.colors"

local M = {}

 function M.setup(s)
    local mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            spacing = 5,
            spacing_widget = {
                {
                    forced_width = 5,
                    -- shape        = gears.shape.rectangle,
                    thickness = 2,
                    color = colors.white .. 30,
                    widget = wibox.widget.separator,
                },
                valign = "center",
                halign = "center",
                widget = wibox.container.place,
            },
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            {
                {
                    {
                        {
                            {
                                id = "icon_role",
                                widget = wibox.widget.imagebox,
                            },
                            margins = 2,
                            widget = wibox.container.margin,
                        },
                        {
                            id = "text_role",
                            widget = wibox.widget.textbox,
                        },
                        layout = wibox.layout.fixed.horizontal,
                    },
                    left = 10,
                    right = 10,
                    widget = wibox.container.margin,
                },
                id = "background_role",
                widget = wibox.container.background,
            },
            width = 200,
            widget = wibox.container.constraint,
        },
    }
    return mytasklist
end

return M
