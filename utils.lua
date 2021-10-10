local gears = require("gears")
local awful = require("awful")
local keys  = require("constants.keys")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi
local gears_table = gears.table

local utils = {}
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
                    client.focus = c
                    c:raise()
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
            {description = "toggle focused client on tag " .. tag_desc.name, group = "tag"}
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




---------------------------------------
-- Autostart windowless processes
---------------------------------------
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end
--
-- run_once({ "urxvtd", "unclutter -root" }) -- comma-separated entries

return utils
