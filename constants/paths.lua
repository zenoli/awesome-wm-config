local paths = {
    root           = os.getenv("HOME") .. "/.config/awesome",
    icons          = os.getenv("HOME") .. "/.config/awesome/icons",
}


paths.widget_icons   =  paths.icons .. "/widgets"
paths.layout_icons   = paths.icons .. "/layouts"
paths.titlebar_icons = paths.icons .. "/titlebar"

return paths
