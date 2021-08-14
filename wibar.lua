local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local layouts = require("layouts")
local taglist = require("taglist")
local taglist_buttons = require("bindings.taglist_buttons")
local tasklist_buttons = require("bindings.tasklist_buttons")
local layoutbox_buttons = require("bindings.layoutbox_buttons")
local utils = require("utils")
local widgetlist = require("widgetlist")

-- widgets
local volume = require("widgets.volume")
local brightness = require("widgets.brightness")
local memory = require("widgets.memory")
local cpu = require("widgets.cpu")
local temperature = require ("widgets.temperature")
local battery = require ("widgets.battery")
local clock = require ("widgets.clock")
local beautiful = require("beautiful")
local update_wallpaper = require("wallpaper")



local string, os = math, string, os


local function setup(s)
    -- taglist(s)
    -- Add app specific tags
    for _, tag_desc in pairs(taglist) do
        local selected = tag_desc.name == "home"

        local tag = awful.tag.add(tag_desc.icon, {
            layout = tag_desc.layout,
            layouts = tag_desc.layouts,
            screen = s,
            selected = selected
        })
    end
    -- Add workspace tags
    for i = 1, beautiful.n_workspace_tags do
        local tag = awful.tag.add(tostring(i), {
            layout = beautiful.workspace_tag_default_layout,
            layouts = layouts,
            screen = s,
            selected = false
        })
        local tag_desc = {
            name = "workspace " .. tostring(i),
            key = "#" .. i + 9
        }
    end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = beautiful.menu_height,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal
    })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        widgetlist(s)
    }
 end

return setup
