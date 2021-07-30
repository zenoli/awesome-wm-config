--[[

     Powerarrow Awesome WM theme
     github.com/lcpz

--]]

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local fs_widget = require("awesome-wm-widgets.fs-widget.fs-widget")
local volume = require("widgets.volume")



local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

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

-- awful.util.tagnames   = {" ", " ", "爵 ", " ", " ", " ", "﬏ ", " ", "祥 ", " ", " ", "1", "2", "3" }


m_tag_ids = {
    tag_home = 1,
    tag_tmux = 2,
    tag_web = 3,
    tag_mail = 4,
    tag_slack = 5,
    tag_video = 6,
    tag_code = 7,
    tag_vim = 8,
    tag_countdown = 9,
    tag_calendar = 10,
    tag_pdf = 11,
    tag_1 = 12,
    tag_2 = 13,
    tag_3 = 14
}


m_icons   = {}
m_icons[m_tag_ids.tag_home      ] = " "
m_icons[m_tag_ids.tag_tmux      ] = " "
m_icons[m_tag_ids.tag_web       ] = "爵 "
m_icons[m_tag_ids.tag_mail      ] = " "
m_icons[m_tag_ids.tag_slack     ] = " "
m_icons[m_tag_ids.tag_video     ] = " "
m_icons[m_tag_ids.tag_code      ] = "﬏ "
m_icons[m_tag_ids.tag_vim       ] = " "
m_icons[m_tag_ids.tag_countdown ] = "祥 "
m_icons[m_tag_ids.tag_calendar  ] = " "
m_icons[m_tag_ids.tag_pdf       ] = " "
m_icons[m_tag_ids.tag_1         ] = "1"
m_icons[m_tag_ids.tag_2         ] = "2"
m_icons[m_tag_ids.tag_3         ] = "3"

local l = awful.layout.suit
local layouts = {
    l.floating,
    l.tile,
    l.magnifier,
    l.tile.top,
    l.fair
}

m_tags = {
    { icon = " " , id = m_tag_ids.tag_home     , layouts = layouts, layout = l.floating  },
    { icon = " " , id = m_tag_ids.tag_tmux     , layouts = layouts, layout = l.tile      },
    { icon = "爵 ", id = m_tag_ids.tag_web      , layouts = layouts, layout = l.tile      },
    { icon = " " , id = m_tag_ids.tag_mail     , layouts = layouts, layout = l.tile      },
    { icon = " " , id = m_tag_ids.tag_slack    , layouts = layouts, layout = l.tile      },
    { icon = " " , id = m_tag_ids.tag_video    , layouts = layouts, layout = l.tile      },
    { icon = "﬏ " , id = m_tag_ids.tag_code     , layouts = layouts, layout = l.magnifier },
    { icon = " " , id = m_tag_ids.tag_vim      , layouts = layouts, layout = l.tile      },
    { icon = "祥 ", id = m_tag_ids.tag_countdown, layouts = layouts, layout = l.tile      },
    { icon = " " , id = m_tag_ids.tag_calendar , layouts = layouts, layout = l.tile      },
    { icon = " " , id = m_tag_ids.tag_pdf      , layouts = layouts, layout = l.fair      },
    { icon = "1"  , id = m_tag_ids.tag_1        , layouts = layouts, layout = l.tile      },
    { icon = "2"  , id = m_tag_ids.tag_2        , layouts = layouts, layout = l.tile      },
    { icon = "3"  , id = m_tag_ids.tag_3        , layouts = layouts, layout = l.tile      }
}


local markup = lain.util.markup
local separators = lain.util.separators
local keyboardlayout = awful.widget.keyboardlayout:new()


-- -- Taskwarrior
-- local task = wibox.widget.imagebox(theme.widget_task)
-- lain.widget.contrib.task.attach(task, {
--     -- do not colorize output
--     show_cmd = "task | sed -r 's/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g'"
-- })
-- task:buttons(my_table.join(awful.button({}, 1, lain.widget.contrib.task.prompt)))


-- Mail IMAP check
--[[ commented because it needs to be set before use
local mailicon = wibox.widget.imagebox(theme.widget_mail)
mailicon:buttons(my_table.join(awful.button({ }, 1, function () awful.spawn(mail) end)))
theme.mail = lain.widget.imap({
    timeout  = 180,
    server   = "server",
    mail     = "mail",
    password = "keyring get mail",
    settings = function()
        if mailcount > 0 then
            widget:set_text(" " .. mailcount .. " ")
            mailicon:set_image(theme.widget_mail_on)
        else
            widget:set_text("")
            mailicon:set_image(theme.widget_mail)
        end
    end
})
--]]

-- ALSA volume
-- theme.volume = lain.widget.alsabar({
--     -- togglechannel = "IEC958,3",
--     notification_preset = { font = "Terminus 10", fg = theme.fg_normal },
-- })

---- MPD
--local musicplr = awful.util.terminal .. " -title Music -g 130x34-320+16 -e ncmpcpp"
--local mpdicon = wibox.widget.imagebox(theme.widget_music)
--mpdicon:buttons(my_table.join(
--    awful.button({ modkey }, 1, function () awful.spawn.with_shell(musicplr) end),
--    awful.button({ }, 1, function ()
--        os.execute("mpc prev")
--        theme.mpd.update()
--    end),
--    awful.button({ }, 2, function ()
--        os.execute("mpc toggle")
--        theme.mpd.update()
--    end),
--    awful.button({ }, 3, function ()
--        os.execute("mpc next")
--        theme.mpd.update()
--    end)))
--theme.mpd = lain.widget.mpd({
--    settings = function()
--        if mpd_now.state == "play" then
--            artist = " " .. mpd_now.artist .. " "
--            title  = mpd_now.title  .. " "
--            mpdicon:set_image(theme.widget_music_on)
--            widget:set_markup(markup.font(theme.font, markup("#FF8466", artist) .. " " .. title))
--        elseif mpd_now.state == "pause" then
--            widget:set_markup(markup.font(theme.font, " mpd paused "))
--            mpdicon:set_image(theme.widget_music_pause)
--        else
--            widget:set_text("")
--            mpdicon:set_image(theme.widget_music)
--        end
--    end
--})

-- Alsa
local alsa = lain.widget.alsa({
    cmd = "amixer -D pulse",
    timeout = 1,
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. volume_now.level))
    end
})

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

--[[ Coretemp (lm_sensors, per core)
local tempwidget = awful.widget.watch({awful.util.shell, '-c', 'sensors | grep Core'}, 30,
function(widget, stdout)
    local temps = ""
    for line in stdout:gmatch("[^\r\n]+") do
        temps = temps .. line:match("+(%d+).*°C")  .. "° " -- in Celsius
    end
    widget:set_markup(markup.font(theme.font, " " .. temps))
end)
--]]
-- Coretemp (lain, average)
local temp = lain.widget.temp({
    settings = function()
        widget:set_markup(markup.font(theme.font, " " .. coretemp_now .. "°C "))
    end
})
--]]
local tempicon = wibox.widget.imagebox(theme.widget_temp)

---- / fs
--local fsicon = wibox.widget.imagebox(theme.widget_hdd)
----[[ commented because it needs Gio/Glib >= 2.54
--theme.fs = lain.widget.fs({
--    notification_preset = { fg = theme.fg_normal, bg = theme.bg_normal, font = "Terminus 10" },
--    settings = function()
--        local fsp = string.format(" %3.2f %s ", fs_now["/"].free, fs_now["/"].units)
--        widget:set_markup(markup.font(theme.font, fsp))
--    end
--})
----]]

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
--local neticon = wibox.widget.imagebox(theme.widget_net)
--local net = lain.widget.net({
--    settings = function()
--        widget:set_markup(markup.fontfg(theme.font, "#FEFEFE", " " .. net_now.received .. " ↓↑ " .. net_now.sent .. " "))
--    end
--})

---- Brigtness
--local brighticon = wibox.widget.imagebox(theme.widget_brightness)
---- If you use xbacklight, comment the line with "light -G" and uncomment the line bellow
---- local brightwidget = awful.widget.watch('xbacklight -get', 0.1,
---- local brightwidget = awful.widget.watch('light -G', 0.1,
--local brightwidget = awful.widget.watch('/home/olivier/.config/zsh/scripts/adjust_brightness.bash -get', 0.1,
--    function(widget, stdout, stderr, exitreason, exitcode)
--        local brightness_level = tonumber(string.format("%.0f", stdout))
--        widget:set_markup(markup.font(theme.font, " " .. brightness_level .. "%"))
--end)

-- Separators
local arrow = separators.arrow_left

-- function theme.powerline_rl(cr, width, height)
--     local arrow_depth, offset = height/2, 0

--     -- Avoid going out of the (potential) clip area
--     if arrow_depth < 0 then
--         width  =  width + 2*arrow_depth
--         offset = -arrow_depth
--     end

--     cr:move_to(offset + arrow_depth         , 0        )
--     cr:line_to(offset + width               , 0        )
--     cr:line_to(offset + width - arrow_depth , height/2 )
--     cr:line_to(offset + width               , height   )
--     cr:line_to(offset + arrow_depth         , height   )
--     cr:line_to(offset                       , height/2 )

--     cr:close_path()
-- end

-- local function pl(widget, bgcolor, padding)
--     return wibox.container.background(wibox.container.margin(widget, dpi(16), dpi(16)), bgcolor, theme.powerline_rl)
-- end

function theme.at_screen_connect(s)

    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    -- awful.tag(awful.util.tagnames, s, awful.layout.layouts)
    for _, tag_desc in pairs(m_tags) do
        selected = tag_desc.id == m_tag_ids.tag_home
        awful.tag.add(tag_desc.icon, {
            layout = tag_desc.layout,
            layouts = tag_desc.layouts,
            screen = s,
            selected = selected
        })
    end

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = theme.menu_height, bg = theme.bg_normal, fg = theme.fg_normal })

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
            wibox.widget.systray(),
            keyboardlayout,
            -- alsa.widget,
            -- volume.widget,
            -- -- fs_widget(),
            -- arrow(theme.bg_normal, "#777E76"),
            -- wibox.container.background(
            --     wibox.container.margin(
            --         wibox.widget {
            --             volume.icon,
            --             volume.widget,
            --             layout = wibox.layout.align.horizontal
            --         }, dpi(2), dpi(3)
            --     ), "#777E76"
            -- ),
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
            -- wibox.container.background(
            --     wibox.container.margin(
            --         wibox.widget {
            --             nil,
            --             neticon,
            --             net.widget,
            --             layout = wibox.layout.align.horizontal
            --         }, dpi(3), dpi(3)
            --     ), "#C0C0A2"),
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
