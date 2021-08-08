local awful = require("awful")
local keys = require("constants.keys")

local l = awful.layout.suit
local taglist = {}

local layouts = {
    l.floating,
    l.tile,
    l.magnifier,
    l.tile.top,
    l.fair,
    l.max
}

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
    },
    {
        icon = "1",
        name = "workspace 1",
        key = "#" .. 1 + 9,
        layouts = layouts,
        layout = l.tile
    },
    {
        icon = "2",
        name = "workspace 2",
        key = "#" .. 2 + 9,
        layouts = layouts,
        layout = l.tile
    },
    {
        icon = "3",
        name = "workspace 3",
        key = "#" .. 3 + 9,
        layouts = layouts,
        layout = l.tile
    }
}

-- taglist.ids = {
--     home = 1,
--     tmux = 2,
--     web = 3,
--     mail = 4,
--     slack = 5,
--     video = 6,
--     code = 7,
--     vim = 8,
--     countdown = 9,
--     calendar = 10,
--     pdf = 11,
--     workspace_1 = 12,
--     workspace_2 = 13,
--     workspace_3 = 14
-- }

-- taglist.icons = {
--     [taglist.ids.home        ] = " ",
--     [taglist.ids.tmux        ] = " ",
--     [taglist.ids.web         ] = "爵 ",
--     [taglist.ids.mail        ] = " ",
--     [taglist.ids.slack       ] = " ",
--     [taglist.ids.video       ] = " ",
--     [taglist.ids.code        ] = "﬏ ",
--     [taglist.ids.vim         ] = " ",
--     [taglist.ids.countdown   ] = "祥 ",
--     [taglist.ids.calendar    ] = " ",
--     [taglist.ids.pdf         ] = " ",
--     [taglist.ids.workspace_1 ] = "1",
--     [taglist.ids.workspace_2 ] = "2",
--     [taglist.ids.workspace_3 ] = "3"
-- }


-- function taglist.get_icon(tag_id)
--     return taglist.icons[taglist.ids[tag_id]]
-- end


return taglist
