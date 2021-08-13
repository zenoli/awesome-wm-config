local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local fs_widget = require("awesome-wm-widgets.fs-widget.fs-widget")
local volume = require("widgets.volume")
local layouts = require("layouts")
local taglist = require("taglist")
local keys = require("constants.keys")
local taglist_buttons = require("bindings.taglist_buttons")
local tasklist_buttons = require("bindings.tasklist_buttons")
local layoutbox_buttons = require("bindings.layoutbox_buttons")
local utils = require("utils")
local naughty        = require("naughty")
local beautiful         = require("beautiful")


local math, string, os = math, string, os
local gears_table = gears.table



local markup = lain.util.markup
local separators = lain.util.separators
local keyboardlayout = awful.widget.keyboardlayout:new()

-- MEM
local memicon = wibox.widget.imagebox(beautiful.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, " " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp (lain, average)
local tempicon = wibox.widget.imagebox(beautiful.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(beautiful.font, " " .. coretemp_now .. "°C "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(beautiful.widget_battery)
local bat = lain.widget.bat({
    timeout = 1,
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(beautiful.font, " AC "))
                baticon:set_image(beautiful.widget_ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(beautiful.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(beautiful.widget_battery_low)
            else
                baticon:set_image(beautiful.widget_battery)
            end
            widget:set_markup(markup.font(beautiful.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup()
            baticon:set_image(beautiful.widget_ac)
        end
    end
})

---- Net
local neticon = wibox.widget.imagebox(beautiful.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(beautiful.font, "#FEFEFE", " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
    end
})


-- Separators
local arrow = separators.arrow_left

local function init(s)

    -- If wallpaper is a function, call it with the screen
    local wallpaper = beautiful.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Add app specific tags
    for _, tag_desc in pairs(taglist) do
        local selected = tag_desc.name == "tmux"

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
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(layoutbox_buttons)
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    s.systray = wibox.widget.systray()
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
            -- spr,
            s.mytaglist,
            s.mypromptbox,
            -- spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            s.systray,
            keyboardlayout,
            arrow("#FFFFFF00", "#777E76"),
            wibox.container.background(
                wibox.container.margin(
                    wibox.widget {
                        memicon,
                        mem.widget,
                        layout = wibox.layout.align.horizontal
                    }, dpi(2), dpi(3)
                ), "#777E76"
            ),
            arrow("#777E76", "#4B696D"),
            wibox.container.background(
                wibox.container.margin(
                    wibox.widget {
                        cpuicon,
                        cpu.widget,
                        layout = wibox.layout.align.horizontal
                    }, dpi(3), dpi(4)
                ), "#4B696D"
            ),
            arrow("#4B696D", "#4B3B51"),
            wibox.container.background(
                wibox.container.margin(
                    wibox.widget {
                        tempicon,
                        temp.widget,
                        layout = wibox.layout.align.horizontal
                    }, dpi(4), dpi(4)
                ), "#4B3B51"
            ),
            arrow("#4B3B51", "#8DAA9A"),
            wibox.container.background(
                wibox.container.margin(
                    wibox.widget {
                        baticon,
                        bat.widget,
                        layout = wibox.layout.align.horizontal
                    }, dpi(3), dpi(3)
                ), "#8DAA9A"
            ),
            arrow("#8DAA9A", "#4B696D"),
            wibox.container.background(
                wibox.container.margin(
                    wibox.widget {
                        volume.icon,
                        volume.widget,
                        layout = wibox.layout.align.horizontal
                    }, dpi(2), dpi(3)
                ), "#4B696D"
            ),
            wibox.container.background(
                wibox.container.margin(
                    brightness_widget{
                        type = 'icon_and_text',
                        program = 'custom',
                        base = 80,
                        step = 5,
                        tooltip = false
                    }, dpi(2), dpi(2)
                ), "#4B696D"
            ),
            arrow("#4B696D", "#CB755B"),
            wibox.container.background(
                wibox.container.margin(
                    wibox.widget.textclock(),
                    dpi(2),dpi(2)
                ), "#CB755B"
            ),
            arrow("#CB755B", beautiful.bg_normal),
            s.mylayoutbox,
        },
    }
 end

