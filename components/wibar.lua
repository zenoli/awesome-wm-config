local awful = require("awful")
local wibox = require("wibox")
local taglist = require("components.taglist")
local taglist_buttons = require("bindings.taglist_buttons")
local tasklist_buttons = require("bindings.tasklist_buttons")
local widgetlist = require("components.widgetlist")
local beautiful = require("beautiful")


local function setup(s)
    taglist.setup(s)

    -- Create a promptbox for each screen
    s.promptbox = awful.widget.prompt()
    s.taglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.tasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

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
            s.taglist,
            s.promptbox,
        },
        s.tasklist, -- Middle widget
        widgetlist(s)
    }
 end

return setup
