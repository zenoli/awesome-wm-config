local colors = require "constants.colors"
local paths = require "constants.paths"
local dpi = require("beautiful.xresources").apply_dpi


local theme                                     = {}

---------------------------------------
-- General
---------------------------------------
-- Fonts
theme.font_size                                 = dpi(9)
theme.font                                      = "Terminus "       .. theme.font_size
theme.taglist_font                              = "Hack Nerd Font " .. theme.font_size

-- Misc
theme.useless_gap                               = dpi(6)
theme.notification_icon_size                    = dpi(30)
theme.border_width                              = dpi(0)
theme.systray_icon_spacing                      = dpi(2)
theme.wibar_bg = colors.red
theme.menu_width                                = dpi(170)
theme.tasklist_plain_task_name                  = false
theme.tasklist_disable_task_name                = false
theme.tasklist_disable_icon                     = false


-- Paths
theme.wallpaper                                 = paths.root .. "/default_wallpaper.jpg"

---------------------------------------
-- Colors
---------------------------------------
theme.fg_normal                                 = colors.brightgrey
theme.fg_focus                                  = colors.orange
theme.fg_urgent                                 = colors.red
theme.bg_normal                                 = colors.bg_normal .. 50
theme.bg_focus                                  = colors.transparent
theme.bg_urgent                                 = colors.darkgrey
theme.tasklist_bg_normal                        = colors.transparent
theme.notification_border_color                 = colors.black
theme.notification_spacing = 10
theme.border_normal                             = colors.transparent
theme.border_focus                              = colors.white
theme.border_marked                             = colors.orange
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.menu_bg_normal                            = theme.bg_normal
theme.menu_height = 30
theme.bg_systray                                = colors.bg_normal


---------------------------------------
-- Wibar
---------------------------------------
theme.wibar_height                              = dpi(30)
theme.wibar_margin                              = dpi(5)

-- taglist
theme.taglist_overline_margin = dpi(4)
theme.taglist_overline_thickness = dpi(2)
---------------------------------------
-- Icons
---------------------------------------
--General
theme.menu_submenu_icon                         = paths.icons .. "/submenu.png"
theme.awesome_icon                              = paths.icons .. "/awesome.png"

-- Layout
theme.layout_tile                               = paths.icons .. "/layouts/tile.png"
theme.layout_tileleft                           = paths.icons .. "/layouts/tileleft.png"
theme.layout_tilebottom                         = paths.icons .. "/layouts/tilebottom.png"
theme.layout_tiletop                            = paths.icons .. "/layouts/tiletop.png"
theme.layout_fairv                              = paths.icons .. "/layouts/fairv.png"
theme.layout_fairh                              = paths.icons .. "/layouts/fairh.png"
theme.layout_spiral                             = paths.icons .. "/layouts/spiral.png"
theme.layout_dwindle                            = paths.icons .. "/layouts/dwindle.png"
theme.layout_max                                = paths.icons .. "/layouts/max.png"
theme.layout_fullscreen                         = paths.icons .. "/layouts/fullscreen.png"
theme.layout_magnifier                          = paths.icons .. "/layouts/magnifier.png"
theme.layout_floating                           = paths.icons .. "/layouts/floating.png"

-- Titlebar
theme.titlebar_close_button_focus               = paths.icons .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal              = paths.icons .. "/titlebar/close_normal.png"
theme.titlebar_ontop_button_focus_active        = paths.icons .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active       = paths.icons .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive      = paths.icons .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive     = paths.icons .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_sticky_button_focus_active       = paths.icons .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active      = paths.icons .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive     = paths.icons .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive    = paths.icons .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_floating_button_focus_active     = paths.icons .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active    = paths.icons .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive   = paths.icons .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive  = paths.icons .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_maximized_button_focus_active    = paths.icons .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = paths.icons .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = paths.icons .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = paths.icons .. "/titlebar/maximized_normal_inactive.png"

return theme
