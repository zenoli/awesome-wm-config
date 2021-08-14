local awful = require("awful")
local layoutbox_buttons = require("bindings.layoutbox_buttons")


local function setup(s)
    layoutbox = awful.widget.layoutbox(s)
    layoutbox:buttons(layoutbox_buttons)

    return {
        widget = layoutbox
    }
end

return setup
