local awful = require("awful")
local wibox = require("wibox")
local taglist = require("components.taglist")
local tasklist = require("components.tasklist")
local taglist_buttons = require("bindings.taglist_buttons")
local tasklist_buttons = require("bindings.tasklist_buttons")
local widgetlist = require("components.widgetlist")
local beautiful = require("beautiful")
local gears            = require("gears")
local colors    = require("constants.colors")
local dpi   = require("beautiful.xresources").apply_dpi

local function update_taglist(self, tag, index, tags)
    local overline = self:get_children_by_id("overline")[1]
    local has_clients = next(tag:clients())
    local is_selected = tag.selected
    if has_clients then
        if is_selected then
            overline.bg = beautiful.fg_focus
        else
            -- overline.bg = beautiful.fg_focus .. 60
            overline.bg = beautiful.fg_normal .. 50
        end
    else
        overline.bg = colors.transparent
    end
end

local function rounded_container(widget, id)
    return {
        {
            {
                {
                    widget,
                    left = beautiful.tag_margin,
                    right = beautiful.tag_margin,
                    widget = wibox.container.margin
                },
                id = id or "rounded_container",
                shape = gears.shape.rounded_bar,
                bg = colors.black .. "30",
                widget = wibox.container.background
            },
            margins = beautiful.tag_margin,
            widget = wibox.container.margin
        },
        layout = wibox.layout.fixed.horizontal,
    }
end


local function setup(s)
    s.promptbox = awful.widget.prompt()
    s.taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    {
                        left = beautiful.taglist_overline_margin,
                        right = beautiful.taglist_overline_margin,
                        widget = wibox.container.margin,
                    },
                    id = "overline",
                    bg = colors.transparent,
                    shape = gears.shape.rectangle,
                    widget = wibox.container.background,
                    forced_height = beautiful.taglist_overline_width,
                },
                {
                    {
                        id = "text_role",
                        align = "center",
                        valign = "center",
                        forced_width = 20,
                        widget = wibox.widget.textbox
                    },
                    left = 3,
                    widget = wibox.container.margin
                },
                layout = wibox.layout.fixed.vertical,

            },
            top = 0,
            bottom = beautiful.taglist_overline_width,
            left = 5,
            right = 5,
            widget = wibox.container.margin,
            -- callbacks:
            create_callback = update_taglist,
            update_callback = update_taglist
        }
    }

    -- Create a tasklist widget
    -- s.tasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)
    s.tasklist = tasklist(s)

    -- Create the wibox
    s.wibar = awful.wibar({
        position = "top",
        screen = s,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal
    })

    -- Add widgets to the wibox
    s.wibar:setup {
        rounded_container(s.taglist, "taglist_container"),
        rounded_container(s.tasklist, "tasklist_container"),
        rounded_container {
            require("widgets.volume").widget,
            require("widgets.battery").widget,
            require("widgets.brightness").widget,
            require("widgets.clock").widget,
            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal,
    }
 end

return setup
