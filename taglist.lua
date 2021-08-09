local awful = require("awful")
local keys = require("constants.keys")
local layouts = require("layouts")

local l = awful.layout.suit


local taglist = {
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
        command = "alacritty -e tmux new-session -s main"
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
        command = "mailspring"
    } ,
    {
        icon = " ",
        name = "slack",
        key = "s",
        layouts = layouts,
        layout = l.tile,
        command = "slack"
    },
    {
        icon = " ",
        name = "video",
        key = "y",
        layouts = layouts,
        layout = l.tile,
        command = "brave-browser"
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
        command =  "alacritty -e tmux new-session -s vimwiki -c /home/olivier/vimwiki 'nvim +VimwikiDiaryIndex +vs +VimwikiMakeDiaryNote'"
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
        command = "gnome-calendar"
    },
    {
        icon = " ",
        name = "pdf",
        key = "p",
        layouts = layouts,
        layout = l.max
    }
}


return taglist
