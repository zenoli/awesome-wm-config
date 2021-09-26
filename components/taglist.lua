local awful = require("awful")
local keys = require("constants.keys")
local layouts = require("layouts")
local naughty        = require("naughty")

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
        command = "alacritty -t 'Tmux' -e tmux new-session -A -s main"
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
        command = "mailspring",
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
        command =  "alacritty -t 'Vimwiki' -e tmux new-session -A -s vimwiki -c /home/olivier/vimwiki 'nvim +VimwikiDiaryIndex +vs +VimwikiMakeDiaryNote'"
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
        command = "gnome-calendar",
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

function taglist.setup(s)

    local multi_screen = screen.count() == 2
    -- naughty.notify { text = "Screen count is: " .. screen.count() }
    -- if multi_screen then
    --     naughty.notify {text = "Multi screen setup!" }
    -- end
    -- Add app specific tags
    for _, tag_desc in pairs(taglist.description) do
        local selected = tag_desc.name == "home"
        local cond_1 = s.index == 2 and not tag_desc.secondary
        local cond_2 = s.index == 1 and tag_desc.secondary
        if not multi_screen or cond_1 or cond_2 then
            local tag = awful.tag.add(tag_desc.icon, {
                layout = tag_desc.layout,
                layouts = tag_desc.layouts,
                screen = s,
                selected = selected
            })
            tag_desc.tag = tag
            tag_desc.screen = s
        end
    end
    -- Add workspace tags
    if not multi_screen or s.index == 2 then
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
        end
    end
end


return taglist
