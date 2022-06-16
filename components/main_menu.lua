local awful         = require("awful")
local beautiful     = require("beautiful")
local freedesktop   = require("freedesktop")
local programs      = require("constants.programs")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")

-- Create a launcher widget and a main menu
local awesome_menu = {
    {
        "Hotkeys",
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end
    },
    { "Manual", string.format("%s -e man awesome", programs.terminal) },
    {
        "Edit config",
        string.format(
            "%s -e %s %s",
            programs.terminal,
            programs.editor,
            awesome.conffile
        )
    },
    { "Restart", awesome.restart },
    { "Quit", function() awesome.quit() end },
}

local main_menu = freedesktop.menu.build {
    before = {
        { "Awesome", awesome_menu, beautiful.awesome_icon },
        -- other triads can be put here
    },
    after = {
        { "Open terminal", programs.terminal },
        -- other triads can be put here
    }
}

return main_menu
