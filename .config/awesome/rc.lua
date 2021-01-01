-- Inspired by https://epsi-rns.github.io/desktop/2019/06/16/awesome-modularized-structure.html

require("main.startup_errors")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
-- require("awful.hotkeys_popup.keys")

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

load_theme("sky_mod")

-- TODO sort out globals
RC = {
    settings = require("main.settings"),
}
RC.interact = require("main.interact")

require("main.taskbar")

root.buttons(RC.interact.global_buttons)
root.keys(RC.interact.global_keys)

local rules = require("main.rules")
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = rules

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile, -- default
    awful.layout.suit.fair,
    awful.layout.suit.tile.top,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
}


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

awful.screen.connect_for_each_screen(function(s) set_wallpaper(s) end)
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)


--  Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- TODO move to interact
    local titlebar_buttons = gears.table.join(
    awful.button({}, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({}, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end)
    )
    awful.titlebar(c):setup {
        {
            -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = RC.interact.titlebar_buttons,
            layout = wibox.layout.fixed.horizontal
        },
        {
            -- Middle
            {
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = RC.interact.titlebar_buttons,
            layout = wibox.layout.flex.horizontal
        },
        nil, -- Hide titlebar buttons
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

require("main.xdg_autorun")
