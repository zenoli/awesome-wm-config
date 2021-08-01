-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Load theme
local beautiful         = require("beautiful")
local theme_path = string.format(
    "%s/awesome/theme.lua",
    os.getenv("XDG_CONFIG_HOME")
)
beautiful.init(theme_path)

local awful          = require("awful")
                       require("awful.autofocus")
local naughty        = require("naughty")

local main_menu      = require("main_menu")
local rules          = require("rules")
local global_keys    = require("bindings.global_keys")
local titlebar_setup = require("titlebar")
local gears          = require("gears")
local gears_table    = gears.table


---------------------------------------
-- Theme initialization
---------------------------------------
-- local theme_path = string.format( "%s/awesome/theme.lua", os.getenv("XDG_CONFIG_HOME"))
-- beautiful.init(theme_path)


---------------------------------------
-- Error handling
---------------------------------------
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


---------------------------------------
-- Autostart windowless processes
---------------------------------------
-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end
--
-- run_once({ "urxvtd", "unclutter -root" }) -- comma-separated entries


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

-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(function(s) beautiful.at_screen_connect(s) end)


---------------------------------------
-- Rules, keys and mouse bindings
---------------------------------------
awful.rules.rules = rules
root.keys(global_keys)
root.buttons(gears_table.join(
    awful.button({ }, 3, function () main_menu:toggle() end)
))


---------------------------------------
-- Signals
---------------------------------------
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
client.connect_signal("request::titlebars", titlebar_setup)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)


---------------------------------------
-- Autostart
---------------------------------------
awful.spawn.with_shell("$HOME/picom/build/src/picom --experimental-backends")
awful.spawn.with_shell("nitrogen --restore")
