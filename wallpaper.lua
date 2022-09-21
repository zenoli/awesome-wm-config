local beautiful = require "beautiful"
local gears = require "gears"

local function update_wallpaper(s)
    -- If wallpaper is a function, call it with the screen
    local wallpaper = beautiful.wallpaper
    if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
    gears.wallpaper.maximized(wallpaper, s, true)
end

return update_wallpaper
