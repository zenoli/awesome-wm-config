local awful       = require("awful")
local keys        = require("constants.keys")
local programs    = require("constants.programs")
local layouts     = require("layouts")
local naughty     = require("naughty")
local utils       = require("utils")

local l = awful.layout.suit

local taglist = {}
taglist.n_workspace_tags = 5
taglist.workspace_tag_default_layout = l.tile


taglist.description = {
    {
        icon = " ",
        name = "home",
        key = "0",
        layouts = layouts,
        layout = l.floating
    },
    {
        icon = " ",
        name = "tmux",
        key = keys.enter,
        layouts = layouts,
        layout = l.tile,
        command = programs.terminal .. " --name Tmux tmux new-session -A -s main"
    },
    {
        icon = "爵 ",
        name = "web",
        key = "b",
        layouts = layouts,
        layout = l.tile,
        command = "qutebrowser"
    },
    {
        icon = " ",
        name = "mail",
        key = "m",
        layouts = layouts,
        layout = l.tile,
        -- command = "mailspring",
        command = "gtk-launch chrome-pkooggnaalmfkidjmlhoelhdllpphaga-Default.desktop",
        secondary = true
    } ,
    {
        icon = " ",
        name = "slack",
        key = "s",
        layouts = layouts,
        layout = l.tile,
        command = "slack",
        secondary = true
    },
    {
        icon = " ",
        name = "video",
        key = "y",
        layouts = layouts,
        layout = l.tile,
        command = "brave-browser",
        secondary = true
    },
    {
        icon = "﬏ ",
        name = "code",
        key = "v",
        layouts = layouts,
        layout = l.magnifier,
        command = "code"
    },
    {
        icon = " ",
        name = "notes",
        key = "w",
        layouts = layouts,
        layout = l.tile,
        command = programs.terminal .. [[ --name Vimwiki ]]
            .. [[tmux new-session -c /home/olivier/vimwiki -A -s vimwiki ]]
            .. [["v +VimwikiDiaryIndex +vs +VimwikiMakeDiaryNote"]]
    },
    {
        icon = "祥 ",
        name = "timer",
        key = "t",
        layouts = layouts,
        layout = l.tile,
        command = "countdown"
    },
    {
        icon = " ",
        name = "calendar",
        key = "c",
        layouts = layouts,
        layout = l.tile,
        -- command = "gnome-calendar",
        command = "gtk-launch chrome-pkooggnaalmfkidjmlhoelhdllpphaga-Default.desktop",
        secondary = true
    },
    {
        icon = " ",
        name = "pdf",
        key = "p",
        layouts = layouts,
        layout = l.max
    }
}


function taglist.init(s)
     -- Add app specific tags
    for _, tag_desc in pairs(taglist.description) do
        -- local selected = tag_desc.name == "home"
        local selected = false
        local tag = awful.tag.add(tag_desc.icon, {
            layout = tag_desc.layout,
            layouts = tag_desc.layouts,
            screen = s,
            selected = selected
        })
        tag_desc.tag = tag
    end
    -- Add workspace tags
    for i = 1, taglist.n_workspace_tags do
        local tag = awful.tag.add(tostring(i), {
            layout = taglist.workspace_tag_default_layout,
            layouts = layouts,
            screen = s,
            selected = false
        })
        local tag_desc = {
            name = "workspace " .. tostring(i),
            key = "#" .. i + 9,
            tag = tag,
        }
        table.insert(taglist.description, tag_desc)
    end
end

function taglist.rearrange_tags(multi_screen)
    local s_laptop = utils.get_laptop_screen()
    local s_ext = multi_screen and utils.get_ext_screen()
    for _, tag_desc in pairs(taglist.description) do
        if multi_screen and not tag_desc.secondary then
            tag_desc.tag.screen = s_ext
        else
            tag_desc.tag.screen = s_laptop
        end
    end
end


return taglist
