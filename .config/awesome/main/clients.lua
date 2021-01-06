-- Configure and manage windows

local awful = require("awful")
local beautiful = require("beautiful")
local gtable = require("gears.table")
local wibox = require("wibox")
require("awful.autofocus")

-- TODO deprecated, use ruled
awful.rules.rules = require("main.rules")

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
    -- TODO move to interact?
    local titlebar_buttons = gtable.join(
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
