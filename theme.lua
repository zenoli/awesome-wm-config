local awful = require("awful")
local dpi   = require("beautiful.xresources").apply_dpi


local theme                                     = {}

---------------------------------------
-- General
---------------------------------------
-- Fonts
theme.font_size                                 = 9
theme.font                                      = "Terminus "       .. theme.font_size
theme.taglist_font                              = "Hack Nerd Font " .. theme.font_size

-- Misc
theme.useless_gap                               = 6
theme.notification_icon_size                    = 30
theme.notification_border_width                 = 10
theme.border_width                              = dpi(0)
theme.systray_icon_spacing                      = dpi(3)
theme.menu_height                               = dpi(19)
theme.menu_width                                = dpi(170)
theme.tasklist_plain_task_name                  = false
theme.tasklist_disable_icon                     = true


-- Paths
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome"
theme.icon_dir                                  = os.getenv("HOME") .. "/.config/awesome/icons"
theme.wallpaper                                 = theme.dir .. "/default_wallpaper.jpg"

---------------------------------------
-- Colors
---------------------------------------
theme.fg_normal                                 = "#FEFEFE"
theme.fg_focus                                  = "#32D6FF"
theme.fg_urgent                                 = "#C83F11"
theme.bg_normal                                 = "#22222290"
theme.bg_systray                                = "#00000000"
theme.bg_focus                                  = "#1E232000"
theme.bg_urgent                                 = "#3F3F3F"
theme.taglist_fg_focus                          = "#F6784F90"
theme.tasklist_bg_focus                         = "#22222200"
theme.tasklist_bg_normal                        = "#00000000"
theme.tasklist_fg_focus                         = "#F6784F"
theme.notification_border_color                 = "#000000"
theme.border_normal                             = "#3F3F3F00"
theme.border_focus                              = theme.bg_focus
theme.border_marked                             = "#CC9393"
theme.titlebar_bg_focus                         = "#3F3F3F"
theme.titlebar_bg_normal                        = "#3F3F3F"
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_bg_normal                            = "#22222240"

---------------------------------------
-- Icons
---------------------------------------
--General
theme.menu_submenu_icon                         = theme.icon_dir .. "/submenu.png"
theme.awesome_icon                              = theme.icon_dir .. "/awesome.png"

-- Taglist
theme.taglist_squares_sel                       = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel                     = theme.icon_dir .. "/square_unsel.png"

-- Layout
theme.layout_tile                               = theme.icon_dir .. "/layouts/tile.png"
theme.layout_tileleft                           = theme.icon_dir .. "/layouts/tileleft.png"
theme.layout_tilebottom                         = theme.icon_dir .. "/layouts/tilebottom.png"
theme.layout_tiletop                            = theme.icon_dir .. "/layouts/tiletop.png"
theme.layout_fairv                              = theme.icon_dir .. "/layouts/fairv.png"
theme.layout_fairh                              = theme.icon_dir .. "/layouts/fairh.png"
theme.layout_spiral                             = theme.icon_dir .. "/layouts/spiral.png"
theme.layout_dwindle                            = theme.icon_dir .. "/layouts/dwindle.png"
theme.layout_max                                = theme.icon_dir .. "/layouts/max.png"
theme.layout_fullscreen                         = theme.icon_dir .. "/layouts/fullscreen.png"
theme.layout_magnifier                          = theme.icon_dir .. "/layouts/magnifier.png"
theme.layout_floating                           = theme.icon_dir .. "/layouts/floating.png"

-- Widgets
theme.widget_ac                                 = theme.icon_dir .. "/widgets/ac.png"
theme.widget_battery                            = theme.icon_dir .. "/widgets/battery.png"
theme.widget_battery_low                        = theme.icon_dir .. "/widgets/battery_low.png"
theme.widget_battery_empty                      = theme.icon_dir .. "/widgets/battery_empty.png"
theme.widget_brightness                         = theme.icon_dir .. "/widgets/brightness.png"
theme.widget_mem                                = theme.icon_dir .. "/widgets/mem.png"
theme.widget_cpu                                = theme.icon_dir .. "/widgets/cpu.png"
theme.widget_temp                               = theme.icon_dir .. "/widgets/temp.png"
theme.widget_net                                = theme.icon_dir .. "/widgets/net.png"
theme.widget_hdd                                = theme.icon_dir .. "/widgets/hdd.png"
theme.widget_music                              = theme.icon_dir .. "/widgets/note.png"
theme.widget_music_on                           = theme.icon_dir .. "/widgets/note_on.png"
theme.widget_music_pause                        = theme.icon_dir .. "/widgets/pause.png"
theme.widget_music_stop                         = theme.icon_dir .. "/widgets/stop.png"
theme.widget_vol                                = theme.icon_dir .. "/widgets/vol.png"
theme.widget_vol_low                            = theme.icon_dir .. "/widgets/vol_low.png"
theme.widget_vol_no                             = theme.icon_dir .. "/widgets/vol_no.png"
theme.widget_vol_mute                           = theme.icon_dir .. "/widgets/vol_mute.png"
theme.widget_mail                               = theme.icon_dir .. "/widgets/mail.png"
theme.widget_mail_on                            = theme.icon_dir .. "/widgets/mail_on.png"
theme.widget_task                               = theme.icon_dir .. "/widgets/task.png"
theme.widget_scissors                           = theme.icon_dir .. "/widgets/scissors.png"

-- Titlebar
theme.titlebar_close_button_focus               = theme.icon_dir .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = theme.icon_dir .. "/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = theme.icon_dir .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = theme.icon_dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = theme.icon_dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = theme.icon_dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = theme.icon_dir .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = theme.icon_dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = theme.icon_dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = theme.icon_dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = theme.icon_dir .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = theme.icon_dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = theme.icon_dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = theme.icon_dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = theme.icon_dir .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = theme.icon_dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = theme.icon_dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = theme.icon_dir .. "/titlebar/maximized_normal_inactive.png"

return theme
