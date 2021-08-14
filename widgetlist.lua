local awful     = require("awful")
local utils     = require("utils")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local lain      = require("lain")

local arrow = lain.util.separators.arrow_left
local keyboardlayout = awful.widget.keyboardlayout:new()

local volume      = require("widgets.volume")
local brightness  = require("widgets.brightness")
local memory      = require("widgets.memory")
local cpu         = require("widgets.cpu")
local temperature = require("widgets.temperature")
local battery     = require("widgets.battery")
local clock       = require("widgets.clock")



local function setup(s)
    return {
        layout = wibox.layout.fixed.horizontal,
        s.systray,
        keyboardlayout,
        arrow("#FFFFFF00", "#777E76"),
        utils.widget_wrapper(memory.widget, "#777E76"),
        arrow("#777E76", "#4B696D"),
        utils.widget_wrapper(cpu.widget, "#4B696D"),
        arrow("#4B696D", "#4B3B51"),
        utils.widget_wrapper(temperature.widget, "#4B3B51"),
        arrow("#4B3B51", "#8DAA9A"),
        utils.widget_wrapper(battery.widget, "#8DAA9A"),
        arrow("#8DAA9A", "#4B696D"),
        utils.widget_wrapper(volume.widget, "#4B696D"),
        utils.widget_wrapper(brightness.widget, "#4B696D"),
        arrow("#4B696D", "#CB755B"),
        utils.widget_wrapper(clock.widget, "#CB755B"),
        arrow("#CB755B", beautiful.bg_normal),
        s.mylayoutbox,
    }
end

return setup

