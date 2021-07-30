--[[

     Awesome WM configuration template
     github.com/lcpz

--]]

-- {{{ Required libraries

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears             = require("gears")
local awful             = require("awful")
                          require("awful.autofocus")
local wibox             = require("wibox")
local beautiful         = require("beautiful")
local naughty           = require("naughty")
local lain              = require("lain")
local menubar           = require("menubar")
local freedesktop       = require("freedesktop")
local hotkeys_popup     = require("awful.hotkeys_popup")
                          require("awful.hotkeys_popup.keys")
local gears_table           = gears.table
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local volume_widget     = require('awesome-wm-widgets.volume-widget.volume')
local volume = require("widgets.volume")


-- }}}

-- {{{ Error handling

-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    }
end

-- Handle runtime errors after startup
do
    local in_error = false

    awesome.connect_signal("debug::error", function (err)
        if in_error then return end

        in_error = true

        naughty.notify {
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        }

        in_error = false
    end)
end

-- }}}

-- {{{ Autostart windowless processes

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ "urxvtd", "unclutter -root" }) -- comma-separated entries

local modkey       = "Mod4"
local altkey       = "Mod1"
local terminal     = "alacritty"
local vi_focus     = false -- vi-like client focus https://github.com/lcpz/awesome-copycats/issues/275
local cycle_prev   = true  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274
local editor       = os.getenv("EDITOR") or "nvim"
local browser      = "qutebrowser"


awful.util.taglist_buttons = gears_table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ altkey }, 1, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end)
)

awful.util.tasklist_buttons = gears_table.join(
    awful.button({ }, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({ }, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end)
)

beautiful.init(string.format("%s/.config/awesome/theme.lua", os.getenv("HOME")))

-- }}}

-- {{{ Menu

-- Create a launcher widget and a main menu
local myawesomemenu = {
    { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "Manual", string.format("%s -e man awesome", terminal) },
    { "Edit config", string.format("%s -e %s %s", terminal, editor, awesome.conffile) },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
}

local mymainmenu = freedesktop.menu.build {
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", terminal },
        -- other triads can be put here
    }
}


-- }}}

-- {{{ Screen

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end)

-- No borders when rearranging only 1 non-floating or maximized client
-- screen.connect_signal("arrange", function (s)
--     for _, c in pairs(s.clients) do
--         c.border_width = 0
--     end
-- end)


-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)

-- }}}

-- {{{ Mouse bindings

root.buttons(gears_table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
))

-- }}}

-- {{{ Key bindings

globalkeys = gears_table.join(
    -- Take a screenshot
    awful.key({ }, "Print", function () awful.util.spawn("gnome-screenshot -i") end),
    awful.key({ altkey }, "Print", function () awful.util.spawn("gnome-screenshot -a") end),
    awful.key({ modkey }, "Print", function () awful.util.spawn("gnome-screenshot -w") end),




    -- Show help
    awful.key({ modkey}, "F1",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),


    -- Non-empty tag browsing
    awful.key({ modkey }, "Left", function () lain.util.tag_view_nonempty(-1) end,
              {description = "view  previous nonempty", group = "tag"}),
    awful.key({ modkey }, "Right", function () lain.util.tag_view_nonempty(1) end,
              {description = "view  previous nonempty", group = "tag"}),


    -- By-direction client focus
    awful.key({ modkey }, "j",
        function()
            if awful.screen.focused().selected_tag.layout == awful.layout.suit.floating then
                awful.client.focus.byidx(-1)
            else
                awful.client.focus.global_bydirection("down")
            end
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            if awful.screen.focused().selected_tag.layout == awful.layout.suit.floating then
                awful.client.focus.byidx(1)
            else
                awful.client.focus.global_bydirection("up")
            end
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),


    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            if cycle_prev then
                awful.client.focus.history.previous()
            else
                awful.client.focus.byidx(-1)
            end
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "cycle with previous/go back", group = "client"}),

    -- Show/hide wibox
    awful.key({ modkey, altkey }, "b", function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "toggle wibox", group = "awesome"}),

    -- On-the-fly useless gaps change
    awful.key({ altkey, "Control" }, "-", function () lain.util.useless_gaps_resize(1) end,
              {description = "increment useless gaps", group = "tag"}),
    awful.key({ altkey, "Control" }, "=", function () lain.util.useless_gaps_resize(-1) end,
              {description = "decrement useless gaps", group = "tag"}),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n", function () lain.util.add_tag() end,
              {description = "add new tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "r", function () lain.util.rename_tag() end,
              {description = "rename tag", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Left", function () lain.util.move_tag(-1) end,
              {description = "move tag to the left", group = "tag"}),
    awful.key({ modkey, "Shift" }, "Right", function () lain.util.move_tag(1) end,
              {description = "move tag to the right", group = "tag"}),
    awful.key({ modkey, "Shift" }, "d", function () lain.util.delete_tag() end,
              {description = "delete tag", group = "tag"}),

    -- Standard program
    awful.key({ altkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey, altkey    }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, altkey    }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
    --           {description = "increase the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
    --           {description = "decrease the number of master clients", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
    --           {description = "increase the number of columns", group = "layout"}),
    -- awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
    --           {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n", function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true})
        end
    end, {description = "restore minimized", group = "client"}),


    -- Screen brightness
    awful.key({ }, "XF86MonBrightnessUp", function () brightness_widget:inc() end, {description = "increase brightness", group = "custom"}),
    awful.key({ }, "XF86MonBrightnessDown", function () brightness_widget:dec() end, {description = "decrease brightness", group = "custom"}),


    -- ALSA volume control
    -- awful.key({ }, "XF86AudioRaiseVolume", function () volume_widget:inc() end,
    --     {description = "volume up", group = "hotkeys"}),
    -- awful.key({ }, "XF86AudioLowerVolume",
    --     function () volume_widget:dec() end,
    --     {description = "volume down", group = "hotkeys"}),
    -- awful.key({ }, "XF86AudioMute",
    --     function () volume_widget:toggle() end,
    --     {description = "toggle mute", group = "hotkeys"}),
 
 
    awful.key({ }, "XF86AudioRaiseVolume",
        function () volume:inc() end,
        {description = "volume up", group = "hotkeys"}),
    awful.key({ }, "XF86AudioLowerVolume",
        function () volume:dec() end,
        {description = "volume down", group = "hotkeys"}),
    awful.key({ }, "XF86AudioMute",
        function () volume:toggle() end,
        {description = "toggle mute", group = "hotkeys"}),

    -- User programs
    awful.key({ altkey }, "b", function () awful.util.spawn("qb_launcher") end,
              {description = "Launch qutebrowser", group = "launcher"}),
    awful.key({ altkey }, "r", function () awful.util.spawn("mranger") end,
              {description = "Launch ranger", group = "launcher"}),
    awful.key({ altkey }, "e", function () awful.util.spawn("nautilus -w") end,
              {description = "Launch nautilus", group = "launcher"}),

    -- Prompt
    awful.key({ altkey }, "space", function () awful.util.spawn('dmenu_run -p Launch') end,
              {description = "run dmenu", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
    --]]
)

clientkeys = gears_table.join(
    awful.key({ altkey, "Control"   }, "m",      lain.util.magnify_client,
              {description = "magnify client", group = "client"}),
    awful.key({ modkey, "Control" }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,           }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ altkey, "Control"}, "f",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ altkey, "Control" }, "l",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"})
)


local function add_tag_bindings(id, key, name, command)
    globalkeys = gears_table.join(globalkeys,
        awful.key(
            { modkey }, key,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[id]
                if tag then
                    tag:view_only()
                    if not next(tag:clients()) then
                        awful.spawn(command)
                    end
                end
             end,
            { description = "view " .. name .. " tag" , group = "tag" }
        ),
        awful.key({ modkey, "Control" }, key,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[id]
                if tag then
                    awful.tag.viewtoggle(tag)
                    local c = client.focus
                    if c then
                        c:swap(awful.client.getmaster())
                    end
                end
            end,
            { description = "toggle " .. name .. " tag", group = "tag" }
        ),
        awful.key({ modkey, "Shift" }, key,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[id]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
               end
            end,
            { description = "move to " .. name .. " tag", group = "tag" }
        )
    )
end


local function add_workspace_tag_bindings(id, key, name)
    globalkeys = gears_table.join(globalkeys,
        awful.key(
            { modkey }, key,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[id]
                if tag then
                    tag:view_only()
                    if not next(tag:clients()) then
                        awful.spawn(command)
                    end
                end
             end,
            { description = "view " .. name .. " tag" , group = "tag" }
        ),
        awful.key({ altkey }, key,
            function ()
                if client.focus then
                    local tag = client.focus.screen.tags[id]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag " .. name, group = "tag"}
        )
    )
end


add_tag_bindings(m_tag_ids.tag_home, "0", "home")
add_tag_bindings(m_tag_ids.tag_tmux, "Return", "tmux", "alacritty -e tmux new-session -s main")
add_tag_bindings(m_tag_ids.tag_web, "b", "web", "qutebrowser")
add_tag_bindings(m_tag_ids.tag_mail, "m", "mail", "mailspring")
add_tag_bindings(m_tag_ids.tag_slack, "s", "slack", "slack")
add_tag_bindings(m_tag_ids.tag_video, "y", "video", "brave-browser")
add_tag_bindings(m_tag_ids.tag_code, "v", "code", "code")
add_tag_bindings(m_tag_ids.tag_vim, "w", "vimwiki", "alacritty -e tmux new-session -s vimwiki -c /home/olivier/vimwiki 'nvim +VimwikiDiaryIndex +vs +VimwikiMakeDiaryNote'")
add_tag_bindings(m_tag_ids.tag_countdown, "t", "countdown", "countdown")
add_tag_bindings(m_tag_ids.tag_calendar, "c", "calendar", "gnome-calendar")
add_tag_bindings(m_tag_ids.tag_pdf, "p", "pdf")
add_workspace_tag_bindings(m_tag_ids.tag_1,"#" .. 1 + 9, "1")
add_workspace_tag_bindings(m_tag_ids.tag_2,"#" .. 2 + 9, "2")
add_workspace_tag_bindings(m_tag_ids.tag_3,"#" .. 3 + 9, "3")


clientbuttons = gears_table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ altkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)

-- }}}

-- {{{ Rules

-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { 
        rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen,
            size_hints_honor = false,
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Gnome-calculator",
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    },
    -- Spawn all pdfs on pdf tag
    {
        -- rule_any = {
        --     class = { "Zathura" },
        -- },
        -- callback = function(c)
        --     if c.tag != m_icons[m_tag_ids.tag_home] do
        --         c.tag = m_icons[m_tag_ids.tag_pdf
        --     end
        -- end
            -- local t = awful.screen.focused().selected_tag
        -- properties = {
        --     tags = { m_icons[m_tag_ids.tag_home], m_icons[m_tag_ids.tag_pdf] },
        --     focus = true,
        --     switch_to_tags = true
        -- }
    },
    {
        rule_any = {
            type = { "normal", "dialog" }
        },
        properties = { titlebars_enabled = false }
    },
    {
        rule_any = {
            type = { "dialog" }
        },
        properties = { titlebars_enabled = false, placement = awful.placement.centered }
    },
    {
        rule_any = {
            class = { "countdown" }
        },
        properties = {
            placement = awful.placement.centered,
            -- width = 500,
            -- height = 350,
            ontop = true,
            floating = true,
            callback = function (c) 
                local w = 500
                local h = 350
                
                local W = awful.screen.focused().geometry.width
                local H = awful.screen.focused().geometry.height

                local x = (W - w)/2
                local y = (H - h)/2

                c:geometry({ x = x, y = y, width = w, height = h })
            end
        }
    },
    {
        rule_any = {
            class = {
                "wifi", 
                -- "ranger",
                "htop",
                "qutebrowser_edit"
            }
        },
        properties = {
            placement = awful.placement.centered,
            ontop = true,
            callback = function (c) 
                lain.util.magnify_client(c)
            end
        }
    }
}

-- }}}

-- {{{ Signals

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
            awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- Custom
    if beautiful.titlebar_fun then
        beautiful.titlebar_fun(c)
        return
    end

    -- Default
    -- buttons for the titlebar
    local buttons = gears_table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c, { size = 16 }) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- }}}

-- {{{ Autostart

-- Autostart
awful.spawn.with_shell("$HOME/picom/build/src/picom --experimental-backends")
awful.spawn.with_shell("nitrogen --restore")
-- }}}
