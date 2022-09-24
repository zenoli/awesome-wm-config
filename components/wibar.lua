local awful = require("awful")
local wibox = require("wibox")
local taglist = require("components.taglist")
local tasklist = require("components.tasklist")
local taglist_buttons = require("bindings.taglist_buttons")
local tasklist_buttons = require("bindings.tasklist_buttons")
local widgetlist = require("components.widgetlist")
local beautiful = require("beautiful")
local gears            = require("gears")
local colors    = require("constants.colors")


local function setup(s)
    -- taglist.setup(s)

    -- Create a promptbox for each screen
    s.promptbox = awful.widget.prompt()
    s.taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    -- s.tasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)
    s.tasklist = tasklist(s)

    -- Create the wibox
    s.wibar = awful.wibar({
        position = "top",
        screen = s,
        height = beautiful.menu_height,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal
    })

    -- Add widgets to the wibox
    s.wibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            {
                {
                    {
                        s.taglist,
                        left = 5,
                        right = 5,
                        widget = wibox.container.margin
                    },
                    -- s.taglist,
                    shape = gears.shape.rounded_bar,
                    bg = colors.black .. "30",
                    widget = wibox.container.background
                },
                margins = 5,
                widget = wibox.container.margin
            },
            s.promptbox,
        },
        s.tasklist, -- Middle widget
        widgetlist(s)
    }
 end

return setup
