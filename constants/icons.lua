local icon_dir = os.getenv("HOME") .. "/.config/awesome/icons"
local layouts_icon_dir = icon_dir .. "/layouts"
local widgets_icon_dir = icon_dir .. "/widgets"

local icons = {
    layouts = {
        tile          = layouts_icon_dir .. "/tile.png",
        tileleft      = layouts_icon_dir .. "/tileleft.png",
        tilebottom    = layouts_icon_dir .. "/tilebottom.png",
        tiletop       = layouts_icon_dir .. "/tiletop.png",
        fairv         = layouts_icon_dir .. "/fairv.png",
        fairh         = layouts_icon_dir .. "/fairh.png",
        spiral        = layouts_icon_dir .. "/spiral.png",
        dwindle       = layouts_icon_dir .. "/dwindle.png",
        max           = layouts_icon_dir .. "/max.png",
        fullscreen    = layouts_icon_dir .. "/fullscreen.png",
        magnifier     = layouts_icon_dir .. "/magnifier.png",
        floating      = layouts_icon_dir .. "/floating.png",
    },
    widgets = {
        ac            = widgets_icon_dir .. "/ac.png",
        battery       = widgets_icon_dir .. "/battery.png",
        battery_low   = widgets_icon_dir .. "/battery_low.png",
        battery_empty = widgets_icon_dir .. "/battery_empty.png",
        brightness    = widgets_icon_dir .. "/brightness.png",
        mem           = widgets_icon_dir .. "/mem.png",
        cpu           = widgets_icon_dir .. "/cpu.png",
        temp          = widgets_icon_dir .. "/temp.png",
        net           = widgets_icon_dir .. "/net.png",
        hdd           = widgets_icon_dir .. "/hdd.png",
        music         = widgets_icon_dir .. "/note.png",
        music_on      = widgets_icon_dir .. "/note_on.png",
        music_pause   = widgets_icon_dir .. "/pause.png",
        music_stop    = widgets_icon_dir .. "/stop.png",
        vol           = widgets_icon_dir .. "/vol.png",
        vol_low       = widgets_icon_dir .. "/vol_low.png",
        vol_no        = widgets_icon_dir .. "/vol_no.png",
        vol_mute      = widgets_icon_dir .. "/vol_mute.png",
        mail          = widgets_icon_dir .. "/mail.png",
        mail_on       = widgets_icon_dir .. "/mail_on.png",
        task          = widgets_icon_dir .. "/task.png",
        scissors      = widgets_icon_dir .. "/scissors.png",
    }
}

return icons
