local gears             = require("gears")
local awful             = require("awful")
local lain              = require("lain")
local hotkeys_popup     = require("awful.hotkeys_popup")
local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")
local volume            = require("widgets.volume")
local brightness         = require("widgets.brightness")
local settings          = require("settings")
local keys              = require("constants.keys")
local programs          = require("constants.programs")
local taglist           = require("components.taglist")
local utils             = require("utils")
local switcher          = require("awesome-switcher")

local gears_table       = gears.table
local l                 = awful.layout.suit


local function init ()
    local global_keys = gears_table.join(
        -- Alt-Tab switcher
        awful.key(
            { keys.alt }, keys.tab,
            function ()
                switcher.switch( 1, "Mod1", "Alt_L", "Shift", "Tab")
            end
        ),
        awful.key(
            { keys.alt, keys.shift}, keys.tab,
            function ()
                switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
            end
        ),

        -- Take a screenshot
        awful.key({          }, keys.printscreen, function () awful.util.spawn("gnome-screenshot -i") end),
        awful.key({ keys.alt }, keys.printscreen, function () awful.util.spawn("gnome-screenshot -a") end),
        awful.key({ keys.mod }, keys.printscreen, function () awful.util.spawn("gnome-screenshot -w") end),

        -- Show help
        awful.key(
            { keys.mod }, "F1",
            hotkeys_popup.show_help,
            {description="show help", group="awesome"}
        ),

        -- Non-empty tag browsing
        awful.key(
            { keys.mod }, keys.left,
            function () utils.navigate_nonempty_tags(-1) end,
            {description = "view  previous nonempty", group = "tag"}
        ),
        awful.key(
            { keys.mod }, keys.right,
            function () utils.navigate_nonempty_tags(1) end,
            {description = "view  previous nonempty", group = "tag"}
        ),
        awful.key(
            { keys.mod }, "o",
            utils.move_tag_to_other_screen,
            {description = "Reorder tags", group = "tag"}
        ),

        -- By-direction client focus
        awful.key(
            { keys.mod }, "j",
            function () utils.navigate_client("down") end,
            {description = "focus down", group = "client"}
        ),
        awful.key(
            { keys.mod }, "k",
            function () utils.navigate_client("up") end,
            {description = "focus up", group = "client"}
        ),
        awful.key(
            { keys.mod }, "h",
            function () utils.navigate_client("left") end,
            {description = "focus left", group = "client"}
        ),
        awful.key(
            { keys.mod }, "l",
            function () utils.navigate_client("right") end,
            {description = "focus right", group = "client"}
        ),

        -- Layout manipulation
        awful.key(
            { keys.mod, keys.alt }, "t",
            function () awful.layout.set(l.tile) end,
            {description = "select tiled layout", group = "layout"}
        ),
        awful.key(
            { keys.mod, keys.alt }, "f",
            function () awful.layout.set(l.floating) end,
            {description = "select floating layout", group = "layout"}
        ),
        awful.key(
            { keys.mod, keys.alt }, "m",
            function () awful.layout.set(l.max) end,
            {description = "select maximized layout", group = "layout"}
        ),
        -- awful.key(
        --     { keys.mod }, keys.space,
        --     function () awful.layout.inc(1) end,
        --     {description = "select next", group = "layout"}
        -- ),
        -- awful.key(
        --     { keys.mod, keys.shift }, keys.space, function () awful.layout.inc(-1) end,
        --     {description = "select previous", group = "layout"}
        -- ),
        awful.key(
            { keys.mod, keys.shift }, "j",
            function () awful.client.swap.byidx(  1) end,
            {description = "swap with next client by index", group = "client"}
        ),
        awful.key(
            { keys.mod, keys.shift }, "k",
            function () awful.client.swap.byidx( -1) end,
            {description = "swap with previous client by index", group = "client"}
        ),
        awful.key(
            { keys.mod, keys.control }, "j",
            function () awful.screen.focus_relative( 1) end,
            {description = "focus the next screen", group = "screen"}
        ),
        awful.key(
            { keys.mod, keys.control }, "k",
            function () awful.screen.focus_relative(-1) end,
            {description = "focus the previous screen", group = "screen"}
        ),
        awful.key(
            { keys.mod }, "u", awful.client.urgent.jumpto,
                  {description = "jump to urgent client", group = "client"}),
        awful.key(
            { keys.mod }, "Tab",
            function ()
                if settings.cycle_prev then
                    awful.client.focus.history.previous()
                else
                    awful.client.focus.byidx(-1)
                end
                if client.focus then
                    client.focus:raise()
                end
            end,
            {description = "cycle with previous/go back", group = "client"}
        ),

        -- Show/hide wibox
        awful.key(
            { keys.mod, keys.alt }, "b",
            -- TODO: Fix this, these variables are no longer defined
            function ()
                -- for s in screen do
                --     s.mywibox.visible = not s.mywibox.visible
                --     if s.mybottomwibox then
                --         s.mybottomwibox.visible = not s.mybottomwibox.visible
                --     end
                -- end
            end,
            {description = "toggle wibox", group = "awesome"}
        ),

        -- On-the-fly useless gaps change
        awful.key(
            { keys.alt, keys.control }, "-",
            function () lain.util.useless_gaps_resize(1) end,
            {description = "increment useless gaps", group = "tag"}
        ),
        awful.key(
            { keys.alt, keys.control }, "=",
            function () lain.util.useless_gaps_resize(-1) end,
            {description = "decrement useless gaps", group = "tag"}
        ),

        -- Standard program
        awful.key(
            { keys.alt }, keys.enter,
            function () awful.spawn(programs.terminal) end,
            {description = "open a terminal", group = "launcher"}
        ),
        awful.key(
            { keys.mod, keys.control }, "r",
            awesome.restart,
            {description = "reload awesome", group = "awesome"}
        ),
        awful.key(
            { keys.mod, keys.shift }, "q",
            awesome.quit,
            {description = "quit awesome", group = "awesome"}
        ),

        awful.key(
            { keys.mod, keys.alt    }, "l",
            function () awful.tag.incmwfact( 0.05) end,
            {description = "increase master width factor", group = "layout"}
        ),
        awful.key(
            { keys.mod, keys.alt    }, "h",
            function () awful.tag.incmwfact(-0.05) end,
            {description = "decrease master width factor", group = "layout"}
        ),

        awful.key(
            { keys.mod, keys.control }, "n",
            function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:emit_signal("request::activate", "key.unminimize", {raise = true})
                end
            end, {description = "restore minimized", group = "client"}
        ),

        -- Screen brightness
        awful.key(
            { }, keys.brightness_up,
            function () brightness:inc() end,
            {description = "increase brightness", group = "custom"}
        ),
        awful.key(
            { },keys.brightness_down,
            function () brightness:dec() end,
            {description = "decrease brightness", group = "custom"}
        ),

        -- Volume controls
        awful.key(
            { }, keys.vol_up,
            function () volume:inc() end,
            {description = "volume up", group = "hotkeys"}
        ),
        awful.key(
            { }, keys.vol_down,
            function () volume:dec() end,
            {description = "volume down", group = "hotkeys"}
        ),
        awful.key(
            { }, keys.vol_mute,
            function () volume:toggle() end,
            {description = "toggle mute", group = "hotkeys"}
        ),

        -- User programs
        awful.key(
            { keys.alt }, "b",
            function () awful.util.spawn("qb_launcher") end,
            {description = "Launch qutebrowser", group = "launcher"}
        ),
        awful.key(
            { keys.alt }, "r",
            function () awful.util.spawn("mranger") end,
            {description = "Launch ranger", group = "launcher"}
        ),
        awful.key(
            { keys.alt }, "e",
            function () awful.util.spawn("nautilus -w") end,
            {description = "Launch nautilus", group = "launcher"}
        ),

        -- Prompt
        awful.key(
            { keys.alt }, "space",
            function () awful.util.spawn('dmenu_run -p Launch') end,
            {description = "run dmenu", group = "launcher"}
        ),
        awful.key(
            { keys.alt }, "f",
            function () awful.util.spawn('file_launcher') end,
            {description = "run dmenu", group = "launcher"}
        ),
        awful.key(
            { keys.mod }, "space",
            function () awful.util.spawn('switch') end,
            {description = "run dmenu window switcher", group = "launcher"}
        ),
        awful.key(
            { keys.mod }, "x",
            function ()
                awful.prompt.run {
                  prompt       = "Run Lua code: ",
                  textbox      = awful.screen.focused().mypromptbox.widget,
                  exe_callback = awful.util.eval,
                  history_path = awful.util.get_cache_dir() .. "/history_eval"
                }
            end,
            {description = "lua execute prompt", group = "awesome"}
        )
    )


    -- Add tag bindings
    for _, tag_desc in pairs(taglist.description) do
        -- local tag = awful.tag.find_by_name(awful.screen.focused(), tag_desc.icon)
        local tag = tag_desc.tag
        global_keys = gears_table.join(global_keys, utils.add_tag_bindings(tag, tag_desc))
    end

    -- Add worskpace tag bindings
    for i = 1, 5 do
        local tag = awful.tag.find_by_name(awful.screen.focused(), tostring(i))
        local tag_desc = {
            name = "workspace " .. tostring(i),
            key = "#" .. i + 9
        }
        global_keys = gears_table.join(global_keys, utils.add_workspace_tag_bindings(tag, tag_desc))
    end
    return global_keys
end

return init
