local awful = require "awful"
local beautiful = require "beautiful"
local client_buttons = require "bindings.client_buttons"
local client_keys = require "bindings.client_keys"
local tag_descriptions = require("components.taglist").description

local function add_centered_floating_rule(class, width, height)
    if type(class) == "string" then class = { class } end
    return {
        rule_any = { class = class },
        properties = {
            ontop = true,
            floating = true,
            callback = function(c) require("utils").place_centered(c, width, height) end,
        },
    }
end

local rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            size_hints_honor = false,
        },
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                "DTA", -- Firefox addon DownThemAll.
                "copyq", -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Gnome-calculator",
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester", -- xev.
            },
            role = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                -- "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            },
        },
        properties = { floating = true },
    },
    {
        rule_any = {
            class = { "Zathura" },
        },
        properties = {
            focus = true,
            focusable = true,
            -- switch_to_tags = true
        },
    },
    {
        rule_any = {
            type = { "normal", "dialog" },
        },
        properties = { titlebars_enabled = false },
    },
    {
        rule_any = {
            type = { "dialog" },
        },
        properties = { titlebars_enabled = false, placement = awful.placement.centered },
    },
    add_centered_floating_rule("countdown", 500, 350),
    add_centered_floating_rule("wifi", 400, 550),
    add_centered_floating_rule({ "htop", "qutebrowser_edit" }, 1000, 70),
}

return rules
