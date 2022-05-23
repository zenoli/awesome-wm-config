local gears             = require("gears")
local awful             = require("awful")
local lain              = require("lain")
local keys              = require("constants.keys")

local gears_table       = gears.table


local client_keys = gears_table.join(
    ---------------------------------------
    -- Client state modifactions
    ---------------------------------------
    awful.key(
        { keys.alt, keys.control }, "m",
        lain.util.magnify_client,
        {description = "magnify client", group = "client"}
    ),
    awful.key(
        { }, "F11",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key(
        { keys.alt, keys.control}, "f",
        awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}
    ),
    awful.key(
        { keys.alt, keys.control }, "t",
        function (c) c.ontop = not c.ontop end,
        {description = "toggle keep on top", group = "client"}
    ),
    awful.key(
        { keys.alt, keys.control }, "n",
        function (c)
            c.minimized = true
        end,
        {description = "minimize", group = "client"}
    ),
    awful.key(
        { keys.alt, keys.control }, "l",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    ),
    ---------------------------------------
    -- Other bindings
    ---------------------------------------
    awful.key(
        { keys.mod }, "q",
        function (c) c:kill() end,
        {description = "close", group = "client"}
    ),
    awful.key(
        { keys.mod, keys.alt }, keys.space,
        function (c) c:swap(awful.client.getmaster()) end,
        {description = "move to master", group = "client"}
    )
)

return client_keys
