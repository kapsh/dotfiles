-- Autostart programs first time Awesome starts

local awful = require("awful")
local glib = require("lgi").GLib

local guard_var = "_AWESOME_AUTOSTART_DONE"

-- Run .config/autostart/.desktop
if glib.getenv(guard_var) == nil then
    awful.spawn.easy_async("dex --environment Awesome --autostart")
    glib.setenv(guard_var, 1)
end
