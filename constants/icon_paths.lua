local icon_dir = os.getenv("HOME") .. "/.config/awesome/icons"
local layouts_icon_dir = icon_dir .. "/layouts"
local widgets_icon_dir = icon_dir .. "/widgets"

local icons = {
    volume = {
        high   = widgets_icon_dir .. "/volume/volume-high.svg",
        medium = widgets_icon_dir .. "/volume/volume-medium.svg",
        low    = widgets_icon_dir .. "/volume/volume-low.svg",
        off    = widgets_icon_dir .. "/volume/volume-off.svg",
        mute   = widgets_icon_dir .. "/volume/volume-mute.svg"
    },
    battery = {
        -- Charging
        charging_10 = widgets_icon_dir .. "/battery/battery-charging_10.svg",
        charging_20 = widgets_icon_dir .. "/battery/battery-charging_20.svg",
        charging_30 = widgets_icon_dir .. "/battery/battery-charging_30.svg",
        charging_50 = widgets_icon_dir .. "/battery/battery-charging_50.svg",
        charging_60 = widgets_icon_dir .. "/battery/battery-charging_60.svg",
        charging_80 = widgets_icon_dir .. "/battery/battery-charging_80.svg",
        charging_90 = widgets_icon_dir .. "/battery/battery-charging_90.svg",

        -- Discharging
        discharging_20 = widgets_icon_dir .. "/battery/battery-discharging_20.svg",
        discharging_30 = widgets_icon_dir .. "/battery/battery-discharging_30.svg",
        discharging_50 = widgets_icon_dir .. "/battery/battery-discharging_50.svg",
        discharging_60 = widgets_icon_dir .. "/battery/battery-discharging_70.svg",
        discharging_80 = widgets_icon_dir .. "/battery/battery-discharging_80.svg",
        discharging_90 = widgets_icon_dir .. "/battery/battery-discharging_90.svg",
        discharging_100 = widgets_icon_dir .. "/battery/battery-discharging_100.svg",

        -- Other
        alert = widgets_icon_dir .. "/battery/battery-alert.svg",
        alert_red = widgets_icon_dir .. "/battery/battery-alert_red.svg",
        fully_charged = widgets_icon_dir .. "/battery/battery-fully-charged.svg"
    },
    time          = widgets_icon_dir .. "/time.svg",
    ac            = widgets_icon_dir .. "/ac.png",
    battery_high  = widgets_icon_dir .. "/battery.png",
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

return icons
