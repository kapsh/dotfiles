local awful = require("awful")
local beautiful = require("beautiful")
local gtable = require("gears.table")

local specrules = {
    -- Floating clients.
    {
        rule_any = {
            instance = {},
            class = {
                "Crow Translate",
                "Pavucontrol",
                "Qalculate-gtk",
                "Wpa_gui",
                "copyq",
                "mpv",
                "org-apache-jmeter-NewDriver", -- startup splash
                "pinentry",
                "vokoscreenNG",
            },
            name = {
                "Event Tester", -- xev.
                "Steam Guard - Computer Authorization Required", -- pin-code window.
            },
            role = {
                "About", -- Thunderbird, Firefox
                "AlarmWindow", -- Thunderbird's calendar.
            },
        },
        properties = {floating = true},
    },
    {
        rule = {
            class = "Apache JMeter", -- graph plugins popup
            name = "win1", -- TODO win2, win3...
        },
        properties = {floating = true},
    },

}

local defaults = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = RC.interact.client_keys,
            buttons = RC.interact.client_buttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        },
    }
}

return gtable.join(defaults, specrules)
