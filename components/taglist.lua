local awful = require "awful"
local keys = require "constants.keys"
local programs = require "constants.programs"
local layouts = require "layouts"
local utils = require "utils"
local beautiful = require "beautiful"
local wibox = require "wibox"
local colors = require "constants.colors"
local gears = require "gears"
local taglist_buttons = require "bindings.taglist_buttons"

local l = awful.layout.suit

local M = {}
M.n_workspace_tags = 5
M.workspace_tag_default_layout = l.tile

M.description = {
    {
        icon = " ",
        name = "home",
        key = "0",
        layouts = layouts,
        layout = l.floating,
    },
    {
        icon = " ",
        name = "tmux",
        key = keys.enter,
        layouts = layouts,
        layout = l.tile,
        command = programs.terminal .. " --name Tmux --title Tmux tmux new-session -A -s main",
    },
    {
        icon = "爵 ",
        name = "web",
        key = "b",
        layouts = layouts,
        layout = l.tile,
        command = "qutebrowser",
        secondary = true,
    },
    {
        icon = " ",
        name = "mail",
        key = "m",
        layouts = layouts,
        layout = l.tile,
        -- command = "mailspring",
        command = "gtk-launch chrome-pkooggnaalmfkidjmlhoelhdllpphaga-Default.desktop",
        secondary = true,
    },
    {
        icon = " ",
        name = "slack",
        key = "s",
        layouts = layouts,
        layout = l.tile,
        command = "slack",
        secondary = true,
    },
    {
        icon = " ",
        name = "video",
        key = "y",
        layouts = layouts,
        layout = l.tile,
        command = "brave-browser",
        secondary = true,
    },
    {
        icon = "﬏ ",
        name = "code",
        key = "v",
        layouts = layouts,
        layout = l.magnifier,
        command = "code",
    },
    {
        icon = " ",
        name = "notes",
        key = "w",
        layouts = layouts,
        layout = l.tile,
        command = programs.terminal
            .. [[ --name Vimwiki --title Vimwiki ]]
            .. [[tmux new-session -c /home/olivier/vimwiki -A -s vimwiki ]]
            .. [["nvim +VimwikiDiaryIndex +vs +VimwikiMakeDiaryNote"]],
    },
    {
        icon = "祥 ",
        name = "timer",
        key = "t",
        layouts = layouts,
        layout = l.tile,
        command = "zeno-countdown",
    },
    {
        icon = " ",
        name = "calendar",
        key = "c",
        layouts = layouts,
        layout = l.tile,
        command = "gnome-calendar",
        -- command = "gtk-launch chrome-pkooggnaalmfkidjmlhoelhdllpphaga-Default.desktop",
        secondary = true,
    },
    {
        icon = " ",
        name = "pdf",
        key = "p",
        layouts = layouts,
        layout = l.max,
    },
}

function M.init(s)
    -- Add app specific tags
    for _, tag_desc in pairs(M.description) do
        local selected = tag_desc.name == "home"
        local selected_secondary = utils.is_multiscreen() and tag_desc.name == "web"
        local screen
        if utils.is_multiscreen() and not tag_desc.secondary then
            screen = utils.get_ext_screen()
        else
            screen = utils.get_laptop_screen()
        end
        -- local selected = false
        local tag = awful.tag.add(tag_desc.icon, {
            layout = tag_desc.layout,
            layouts = tag_desc.layouts,
            screen = screen,
            selected = selected or selected_secondary,
        })
        tag_desc.tag = tag
    end
    -- Add workspace tags
    for i = 1, M.n_workspace_tags do
        local screen = utils.is_multiscreen()
            and utils.get_ext_screen()
            or utils.get_laptop_screen()

        local tag = awful.tag.add(tostring(i), {
            layout = M.workspace_tag_default_layout,
            layouts = layouts,
            screen = screen,
            selected = false,
        })
        local tag_desc = {
            name = "workspace " .. tostring(i),
            key = "#" .. i + 9,
            tag = tag,
        }
        table.insert(M.description, tag_desc)
    end
end

function M.rearrange_tags(multi_screen)
    local s_laptop = utils.get_laptop_screen()
    local s_ext = multi_screen and utils.get_ext_screen()
    for _, tag_desc in pairs(M.description) do
        if multi_screen and not tag_desc.secondary then
            tag_desc.tag.screen = s_ext
        else
            tag_desc.tag.screen = s_laptop
        end
    end
end

local function update_taglist(self, tag, index, tags)
    local overline = self:get_children_by_id("overline")[1]
    local has_clients = next(tag:clients())
    local is_selected = tag.selected
    if has_clients then
        if is_selected then
            overline.bg = beautiful.fg_focus
        else
            overline.bg = beautiful.fg_normal .. 50
        end
    else
        overline.bg = colors.transparent
    end
end

function M.setup(s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    {
                        left = beautiful.taglist_overline_margin,
                        right = beautiful.taglist_overline_margin,
                        widget = wibox.container.margin,
                    },
                    id = "overline",
                    bg = colors.transparent,
                    shape = gears.shape.rectangle,
                    widget = wibox.container.background,
                    forced_height = beautiful.taglist_overline_thickness,
                },
                {
                    {
                        id = "text_role",
                        align = "center",
                        valign = "center",
                        forced_width = 15,
                        widget = wibox.widget.textbox,
                    },
                    left = 3,
                    widget = wibox.container.margin,
                },
                layout = wibox.layout.fixed.vertical,
            },
            top = 0,
            bottom = beautiful.taglist_overline_width,
            left = 5,
            right = 5,
            widget = wibox.container.margin,
            -- callbacks:
            create_callback = update_taglist,
            update_callback = update_taglist,
        },
    }
end

return M
