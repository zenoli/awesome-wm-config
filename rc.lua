pcall(require, "luarocks.loader")

---------------------------------------
-- Theme initialization
---------------------------------------
local beautiful         = require("beautiful")
local theme_path = string.format(
    "%s/awesome/theme.lua",
    os.getenv("XDG_CONFIG_HOME")
)
beautiful.init(theme_path)

local awful          = require("awful")
                       require("awful.autofocus")
local naughty        = require("naughty")
naughty.config.defaults.border_width = 0

local gears            = require("gears")
local main_menu        = require("components.main_menu")
local rules            = require("rules")
local global_keys      = require("bindings.global_keys")
local wibar_setup      = require("components.wibar")
local taglist          = require("components.taglist")
local titlebar_setup   = require("components.titlebar")
local update_wallpaper = require("wallpaper")
local switcher         = require("awesome-switcher")
local utils            = require("utils")
local gears_table      = gears.table

---------------------------------------
-- Alt-tab switcher settings
---------------------------------------
switcher.settings.cycle_raise_client = false
switcher.settings.preview_box_delay = 0


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


screen.connect_signal("property::geometry", update_wallpaper)

---------------------------------------
-- Multi-Screen setup
---------------------------------------

local function init_screen(s)
    taglist.init(s)
    wibar_setup(s)
end

init_screen(awful.screen.focused())


screen.connect_signal(
    "added",
    function (s)
        -- naughty.notify { text = "Added "   .. s.index }
        taglist.rearrange_tags(true)
        wibar_setup(s)
    end
)
screen.connect_signal(
    "removed",
    function (s)
        -- naughty.notify { text = "Removed " .. s.index }
        taglist.rearrange_tags(false)
    end
)

tag.connect_signal(
    "request::screen",
    function(t)
        t.screen = utils.get_laptop_screen()
    end
)

---------------------------------------
-- Rules, keys and mouse bindings
---------------------------------------
awful.rules.rules = rules
root.keys(global_keys())
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
awful.spawn.with_shell("picom")
-- awful.spawn.with_shell("picom --experimental-backends")
-- awful.spawn.with_shell("xrandr --output eDP-1 --auto --output HDMI-1 --auto --above eDP-1")
awful.spawn.with_shell("nitrogen --restore")

