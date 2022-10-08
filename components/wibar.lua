local awful = require "awful"
local wibox = require "wibox"
local taglist = require "components.taglist"
local tasklist = require "components.tasklist"
local beautiful = require "beautiful"
local gears = require "gears"
local colors = require "constants.colors"

local function rounded_container(widget, id, bg_color)
    return {
        {
            {
                {
                    widget,
                    left = 8,
                    right = 8,
                    widget = wibox.container.margin,
                },
                id = id or "rounded_container",
                shape = gears.shape.rounded_bar,
                bg = bg_color or colors.black .. 30,
                widget = wibox.container.background,
            },
            margins = beautiful.wibar_margin,
            widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.horizontal,
    }
end

local function setup(s)
    s.promptbox = awful.widget.prompt()
    s.taglist = taglist.setup(s)
    s.tasklist = tasklist.setup(s)

    s.wibar = awful.wibar {
        position = "top",
        screen = s,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal,
    }

    -- Add widgets to the wibox
    s.wibar:setup {
        rounded_container(s.taglist, "taglist_container"),
        rounded_container(s.tasklist, "tasklist_container"),
        -- widgets
        {
            -- info-widgets
            rounded_container({
                require("widgets.keyboardlayout").widget,
                require("widgets.volume").widget,
                require("widgets.battery").widget,
                require("widgets.brightness").widget,
                require("widgets.date").widget,
                require("widgets.clock").widget,
                spacing_widget = {
                    {
                        forced_width = 5,
                        shape = gears.shape.circle,
                        thickness = 2,
                        color = colors.white .. 30,
                        widget = wibox.widget.separator,
                    },
                    valign = "center",
                    halign = "center",
                    widget = wibox.container.place,
                },
                spacing = 25,
                layout = wibox.layout.fixed.horizontal,
            }, "widgets_container"),
            -- systray/layouts
            rounded_container({
                require("widgets.systray").widget,
                require "widgets.layoutbox"(s).widget,
                layout = wibox.layout.fixed.horizontal,
            }, "systray_layout_container", colors.bg_normal),
            layout = wibox.layout.fixed.horizontal,
        },
        layout = wibox.layout.align.horizontal,
    }
end

return setup
