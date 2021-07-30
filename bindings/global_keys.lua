local gears             = require("gears")
local awful             = require("awful")
local lain              = require("lain")
local menubar           = require("menubar")
local hotkeys_popup     = require("awful.hotkeys_popup")
                          require("awful.hotkeys_popup.keys")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local volume_widget     = require('awesome-wm-widgets.volume-widget.volume')
local volume            = require("widgets.volume")
local keys              = require("constants.keys")
local programs              = require("constants.programs")
local modkey = keys.mod
local altkey = keys.alt

local gears_table       = gears.table

local global_keys = gears_table.join(
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
    awful.key({ altkey,           }, "Return", function () awful.spawn(programs.terminal) end,
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

local function add_tag_bindings(id, key, name, command)
    global_keys = gears_table.join(global_keys,
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
    global_keys = gears_table.join(global_keys,
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

return global_keys
