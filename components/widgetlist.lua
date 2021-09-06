local awful     = require("awful")
local beautiful = require("beautiful")
local utils     = require("utils")
local wibox     = require("wibox")
local lain      = require("lain")
local colors    = require("constants.colors")

local arrow = lain.util.separators.arrow_left

local systray        = require("widgets.systray")
local keyboardlayout = require("widgets.keyboardlayout")
local volume         = require("widgets.volume")
local brightness     = require("widgets.brightness")
local memory         = require("widgets.memory")
local cpu            = require("widgets.cpu")
local temperature    = require("widgets.temperature")
local battery        = require("widgets.battery")
local clock          = require("widgets.clock")
local layoutbox      = require("widgets.layoutbox")



local function setup(s)
    return {
        layout = wibox.layout.fixed.horizontal,
        utils.widget_wrapper(keyboardlayout.widget, "#00000000"),
        arrow(colors.transparent, beautiful.bg_systray),
        utils.widget_wrapper(systray.widget, beautiful.bg_systray),
        -- utils.widget_wrapper(memory.widget, "#777E76"),
        -- arrow("#777E76", "#4B696D"),
        -- utils.widget_wrapper(cpu.widget, "#4B696D"),
        -- arrow("#4B696D", "#4B3B51"),
        -- utils.widget_wrapper(temperature.widget, "#4B3B51"),
        -- arrow("#4B3B51", "#8DAA9A"),
        utils.widget_wrapper(battery.widget, beautiful.bg_systray),
        arrow(beautiful.bg_systray, colors.darkblue),
        -- arrow("#8DAA9A", "#4B696D"),
        utils.widget_wrapper(volume.widget, colors.darkblue),
        utils.widget_wrapper(brightness.widget, colors.darkblue),
        arrow( colors.darkblue, colors.darkgrey),
        utils.widget_wrapper(clock.widget, colors.darkgrey),
        arrow(colors.darkgrey, colors.layoutbox_bg),
        utils.widget_wrapper(layoutbox(s).widget, colors.layoutbox_bg)
    }
end


return setup

