local gears = require("gears")
local awful = require("awful")
local keys  = require("constants.keys")
local wibox = require("wibox")
local lain = require("lain")
local dpi   = require("beautiful.xresources").apply_dpi
local colors    = require("constants.colors")
local beautiful = require "beautiful"
local gears_table = gears.table

local utils = {}

---------------------------------------
-- Tag Bindings
---------------------------------------
function utils.add_tag_bindings(tag, tag_desc)
    return gears_table.join(
        awful.key(
            { keys.mod }, tag_desc.key,
            function ()
                tag:view_only()
                awful.screen.focus(tag.screen)
                local c = next(tag:clients())
                if not c then
                    if tag_desc.command then
                        awful.spawn(tag_desc.command)
                    end
                else
                    local c = tag:clients()[1]
                    -- client.focus = c
                    -- c:raise()
                end
             end,
            { description = "view " .. tag_desc.name .. " tag" , group = "tag" }
        ),
        awful.key({ keys.mod, keys.control}, tag_desc.key,
            function ()
                awful.tag.viewtoggle(tag)
                local c = client.focus
                if c then
                    c:swap(awful.client.getmaster())
                end
            end,
            { description = "toggle " .. tag_desc.name .. " tag", group = "tag" }
        ),
        awful.key({ keys.mod, keys.shift}, tag_desc.key,
            function ()
                if client.focus then
                    client.focus:move_to_tag(tag)
               end
            end,
            { description = "move to " .. tag_desc.name .. " tag", group = "tag" }
        )
    )
end


function utils.add_workspace_tag_bindings(tag, tag_desc)
    local tag_bindings = utils.add_tag_bindings(tag, tag_desc)
    local workspace_tag_bindings = gears_table.join(
        awful.key({ keys.alt }, tag_desc.key,
            function ()
                if client.focus then
                    client.focus:toggle_tag(tag)
                end
            end,
            { description = "toggle focused client on tag " .. tag_desc.name, group = "tag" }
        )
    )
    return gears_table.join(tag_bindings, workspace_tag_bindings)
end

function utils.widget_wrapper(widget, bg_color)
    return wibox.container.background(
        wibox.container.margin(widget, dpi(2), dpi(3)),
        bg_color
    )
end

function utils.create_widget(widget, icon, bg_color)
    return wibox.container.background(
        wibox.container.margin(
            wibox.widget {
                widget,
                icon,
                layout = wibox.layout.align.horizontal
            }, dpi(2), dpi(3)
        ), bg_color
    )
end

---------------------------------------
-- Screen managment
---------------------------------------
function utils.get_laptop_screen() return screen[1] end
function utils.get_ext_screen() return screen[2] end


---------------------------------------
-- Global Key Actions
---------------------------------------

function utils.move_tag_to_other_screen()
    if screen.count() == 2 then
        local t = awful.screen.focused().selected_tag
        if not t then return end
        local s_laptop = utils.get_laptop_screen()
        local s_ext = utils.get_ext_screen()
        if t.screen == s_laptop then
            t.screen = s_ext
        else
            t.screen = s_laptop
        end
        awful.screen.focus(t.screen.index)
        t:view_only()
    end
end

function utils.navigate_nonempty_tags(d)
    local t = awful.screen.focused().selected_tag
    if not t then
        awful.screen.focused().tags[1]:view_only()
    end
    lain.util.tag_view_nonempty(d)
end

function utils.navigate_client(d)
    local l = awful.screen.focused().selected_tag.layout
    if (l == awful.layout.suit.floating) or (l == awful.layout.suit.max) then
        local idx
        if d == "up" or d == "right" then idx = 1 else idx = -1 end
        awful.client.focus.byidx(idx)
    else
        awful.client.focus.global_bydirection(d)
    end
    if client.focus then client.focus:raise() end
end

---------------------------------------
-- Misc
---------------------------------------
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

function utils.is_zenbook()
    return os.getenv("DEVICE_NAME") == "zenbook-14"
end

-- Hide tasklist on tile layout
function utils.hide_tasklist_on_tiled_layout(t)
    local show_tasklist = t.selected and t.layout.name ~= "tile" and next(t:clients())
    local tasklist_container = t.screen.wibar:get_children_by_id("tasklist_container")[1]
    t.screen.tasklist:set_visible(show_tasklist)
    if show_tasklist then
        tasklist_container.bg = colors.black .. 30
    else
        tasklist_container.bg = colors.black .. 00
    end
end

function utils.capitalize(str)
    return (str:gsub("^%l", string.upper))
end

return utils


