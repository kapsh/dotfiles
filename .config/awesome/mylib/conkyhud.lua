-- Show/hide Conky HUD
-- Based on https://awesome.naquadah.org/wiki/Conky_HUD

local awful = require("awful")
local timer = timer

module("conkyhud")

local conkyhud = {} 

local conky = nil

function get_conky(default)
    if conky and conky.valid then
        return conky
    end

    conky = awful.client.iterate(function(c) return c.class == "Conky" end)()
    return conky or default
end

function conkyhud.raise_conky()
    get_conky({}).ontop = true
end

function conkyhud.lower_conky()
    get_conky({}).ontop = false
end

local t = timer({ timeout = 2 })
t:connect_signal("timeout", function()
    t:stop()
    conkyhud.lower_conky()
end)

function conkyhud.lower_conky_delayed()
    t:again()
end

function conkyhud.toggle_conky()
    local conky = get_conky({})
    conky.ontop = not conky.ontop
end

return conkyhud
