local gears = require("gears")
local awful = require("awful")
local keys = require("constants.keys")
local gears_table = gears.table

local utils = {}
function utils.add_tag_bindings(tag, tag_desc)
    return gears_table.join(
        awful.key(
            { keys.mod }, tag_desc.key,
            function ()
                tag:view_only()
                if tag_desc.command and not next(tag:clients()) then
                    awful.spawn(tag_desc.command)
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

return utils
