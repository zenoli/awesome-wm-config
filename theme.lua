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



local math, string, os = math, string, os
local gears_table = gears.table

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/icons"
theme.wallpaper                                 = theme.dir .. "/default_wallpaper.jpg"
theme.font                                      = "Terminus 9"
theme.taglist_font                              = "Hack Nerd Font"
theme.fg_normal                                 = "#FEFEFE"
theme.fg_focus                                  = "#32D6FF"
theme.fg_urgent                                 = "#C83F11"
theme.bg_normal                                 = "#22222290"
theme.bg_systray                                = "#00000000"
-- theme.bg_normal                                 = "#00000000"
theme.bg_focus                                  = "#1E232000"
-- theme.bg_focus                                  = "#00000000"
theme.bg_urgent                                 = "#3F3F3F"
theme.taglist_fg_focus                          = "#F6784F90"
theme.tasklist_bg_focus                         = "#22222200"
theme.tasklist_bg_normal                         = "#00000000"
theme.tasklist_fg_focus                         = "#F6784F"
theme.border_width                              = dpi(0)
theme.border_normal                             = "#3F3F3F00"
-- theme.border_focus                              = "#6F6F6F"
theme.border_focus                              = theme.bg_focus
theme.border_marked                             = "#CC9393"
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_bg_normal = "#22222240"
theme.menu_height                               = dpi(19)
theme.menu_width                                = dpi(170)
theme.menu_submenu_icon                         = theme.icon_dir .. "/submenu.png"
theme.awesome_icon                              = theme.icon_dir .. "/awesome.png"
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"
theme.layout_tile                               = theme.icon_dir .. "/layouts/tile.png"
theme.layout_tileleft                           = theme.icon_dir .. "/layouts/tileleft.png"
theme.layout_tilebottom                         = theme.icon_dir .. "/layouts/tilebottom.png"
theme.layout_tiletop                            = theme.icon_dir .. "/layouts/tiletop.png"
theme.layout_fairv                              = theme.icon_dir .. "/layouts/fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "/layouts/fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "/layouts/spiral.png"
theme.layout_dwindle                            = theme.icon_dir .. "/layouts/dwindle.png"
theme.layout_max                                = theme.icon_dir .. "/layouts/max.png"
theme.layout_fullscreen                         = theme.icon_dir .. "/layouts/fullscreen.png"
theme.layout_magnifier                          = theme.icon_dir .. "/layouts/magnifier.png"
theme.layout_floating                           = theme.icon_dir .. "/layouts/floating.png"
theme.widget_ac                                 = theme.icon_dir .. "/widgets/ac.png"
theme.widget_battery                            = theme.icon_dir .. "/widgets/battery.png"
theme.widget_battery_low                        = theme.icon_dir .. "/widgets/battery_low.png"
theme.widget_battery_empty                      = theme.icon_dir .. "/widgets/battery_empty.png"
theme.widget_brightness                         = theme.icon_dir .. "/widgets/brightness.png"
theme.widget_mem                                = theme.icon_dir .. "/widgets/mem.png"
theme.widget_cpu                                = theme.icon_dir .. "/widgets/cpu.png"
theme.widget_temp                               = theme.icon_dir .. "/widgets/temp.png"
theme.widget_net                                = theme.icon_dir .. "/widgets/net.png"
theme.widget_hdd                                = theme.icon_dir .. "/widgets/hdd.png"
theme.widget_music                              = theme.icon_dir .. "/widgets/note.png"
theme.widget_music_on                           = theme.icon_dir .. "/widgets/note_on.png"
theme.widget_music_pause                        = theme.icon_dir .. "/widgets/pause.png"
theme.widget_music_stop                         = theme.icon_dir .. "/widgets/stop.png"
theme.widget_vol                                = theme.icon_dir .. "/widgets/vol.png"
theme.widget_vol_low                            = theme.icon_dir .. "/widgets/vol_low.png"
theme.widget_vol_no                             = theme.icon_dir .. "/widgets/vol_no.png"
theme.widget_vol_mute                           = theme.icon_dir .. "/widgets/vol_mute.png"
theme.widget_mail                               = theme.icon_dir .. "/widgets/mail.png"
theme.widget_mail_on                            = theme.icon_dir .. "/widgets/mail_on.png"
theme.widget_task                               = theme.icon_dir .. "/widgets/task.png"
theme.widget_scissors                           = theme.icon_dir .. "/widgets/scissors.png"
theme.tasklist_plain_task_name                  = false
theme.tasklist_disable_icon                     = true
theme.useless_gap                               = 6
theme.titlebar_close_button_focus               = theme.icon_dir .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.icon_dir .. "/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.icon_dir .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.icon_dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.icon_dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.icon_dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.icon_dir .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.icon_dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.icon_dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.icon_dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.icon_dir .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.icon_dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.icon_dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.icon_dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.icon_dir .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.icon_dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.icon_dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.icon_dir .. "/titlebar/maximized_normal_inactive.png"
theme.n_workspace_tags = 5
theme.workspace_tag_default_layout = awful.layout.suit.tile


local markup = lain.util.markup
local separators = lain.util.separators
local keyboardlayout = awful.widget.keyboardlayout:new()

-- MEM
local memicon = wibox.widget.imagebox(theme.widget_mem)
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. mem_now.used .. "MB "))
    end
})

-- CPU
local cpuicon = wibox.widget.imagebox(theme.widget_cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. cpu_now.usage .. "% "))
    end
})

-- Coretemp (lain, average)
local tempicon = wibox.widget.imagebox(theme.widget_temp)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})

-- Battery
local baticon = wibox.widget.imagebox(theme.widget_battery)
local bat = lain.widget.bat({
    timeout = 1,
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
                widget:set_markup(markup.font(theme.font, " AC "))
                baticon:set_image(theme.widget_ac)
                return
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 5 then
                baticon:set_image(theme.widget_battery_empty)
            elseif not bat_now.perc and tonumber(bat_now.perc) <= 15 then
                baticon:set_image(theme.widget_battery_low)
            else
                baticon:set_image(theme.widget_battery)
            end
            widget:set_markup(markup.font(theme.font, " " .. bat_now.perc .. "% "))
        else
            widget:set_markup()
            baticon:set_image(theme.widget_ac)
        end
    end
})

---- Net
local neticon = wibox.widget.imagebox(theme.widget_net)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.fontfg(theme.font, "#FEFEFE", " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
    end
})


-- Separators
local arrow = separators.arrow_left

theme.tag_keys = {}
-- local function add_tag_bindings(tag, tag_desc)
--     theme.tag_keys = gears_table.join(theme.tag_keys,
--         awful.key(
--             { keys.mod }, tag_desc.key,
--             function ()
--                 tag:view_only()
--                 if tag_desc.command and not next(tag:clients()) then
--                     awful.spawn(tag_desc.command)
--                 end
--              end,
--             { description = "view " .. tag_desc.name .. " tag" , group = "tag" }
--         ),
--         awful.key({ keys.mod, keys.control}, tag_desc.key,
--             function ()
--                 awful.tag.viewtoggle(tag)
--                 local c = client.focus
--                 if c then
--                     c:swap(awful.client.getmaster())
--                 end
--             end,
--             { description = "toggle " .. tag_desc.name .. " tag", group = "tag" }
--         ),
--         awful.key({ keys.mod, keys.shift}, tag_desc.key,
--             function ()
--                 if client.focus then
--                     client.focus:move_to_tag(tag)
--                end
--             end,
--             { description = "move to " .. tag_desc.name .. " tag", group = "tag" }
--         )
--     )
-- end


-- local function add_workspace_tag_bindings(tag, tag_desc)
--     add_tag_bindings(tag, tag_desc)
--     theme.tag_keys = gears_table.join(theme.tag_keys,
--         awful.key({ keys.alt }, tag_desc.key,
--             function ()
--                 if client.focus then
--                     client.focus:toggle_tag(tag)
--                 end
--             end,
--             {description = "toggle focused client on tag " .. tag_desc.name, group = "tag"}
--         )
--     )
-- end

function theme.at_screen_connect(s)

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
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
        -- add_tag_bindings(tag, tag_desc)
        theme.tag_keys = gears_table.join(theme.tag_keys, utils.add_tag_bindings(tag, tag_desc))
    end
    -- Add workspace tags
    for i = 1, theme.n_workspace_tags do
        local tag = awful.tag.add(tostring(i), {
            layout = theme.workspace_tag_default_layout,
            layouts = layouts,
            screen = s,
            selected = false
        })
        local tag_desc = {
            name = "workspace " .. tostring(i),
            key = "#" .. i + 9
        }
        -- add_workspace_tag_bindings(tag, tag_desc)
        theme.tag_keys = gears_table.join(theme.tag_keys, utils.add_workspace_tag_bindings(tag, tag_desc))
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
        height = theme.menu_height,
        bg = theme.bg_normal,
        fg = theme.fg_normal
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
            arrow("#CB755B", theme.bg_normal),
            s.mylayoutbox,
        },
    }
 end

return theme
