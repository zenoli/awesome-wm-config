local awful          = require("awful")
local beautiful      = require("beautiful")
local lain           = require("lain")
local client_buttons = require("bindings.client_buttons")
local client_keys    = require("bindings.client_keys")

local rules = {
    -- All clients will match this rule.
    { 
        rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = client_keys,
            buttons = client_buttons,
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
    -- {
    --     rule_any = {
    --         class = { "Zathura" },
    --     },
    --     properties = {
    --         tags = { m_icons[m_tag_ids.tag_home], m_icons[m_tag_ids.tag_pdf] },
    --         focus = true,
    --         switch_to_tags = true
    --     }
    -- },
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
            floating = true,
            -- callback = function (c) 
            --     lain.util.magnify_client(c)
            -- end
        }
    }
}

return rules
