local brightness_widget = require("awesome-wm-widgets.brightness-widget.brightness")

local brightness = {
    widget = brightness_widget{
        type = 'icon_and_text',
        program = 'custom',
        base = 80,
        step = 5,
        tooltip = false
    }
}

return brightness
