-- Inspired by https://epsi-rns.github.io/desktop/2019/06/16/awesome-modularized-structure.html

local gears = require("gears")
local awful = require("awful")
require("main.startup_errors")

-- TODO sort out globals
RC = {
    settings = require("main.settings"),
}
RC.interact = require("main.interact")

require("main.theme")
require("main.layout")
require("main.taskbar")
require("main.clients")

root.buttons(RC.interact.global_buttons)
root.keys(RC.interact.global_keys)

require("main.xdg_autorun")
