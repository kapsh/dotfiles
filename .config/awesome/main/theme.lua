local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local gfs = gears.filesystem

function load_theme(name)
    local theme_path = gfs.get_configuration_dir() .. "themes/" .. name .. "/theme.lua"
    if not gfs.file_readable(theme_path) then
        theme_path = gfs.get_themes_dir() .. name .. "/theme.lua"
    end
    if not gfs.file_readable(theme_path) then
        naughty.notify({
            preset = naughty.config.presets.critical,
            text = "Cannot find theme " .. name
        })
        theme_path = gfs.get_themes_dir() .. "default/theme.lua"
    end
    beautiful.init(theme_path)
end

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper

        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

load_theme("sky_mod")
awful.screen.connect_for_each_screen(function(s) set_wallpaper(s) end)
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
