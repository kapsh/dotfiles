-- TODO https://github.com/Elv13/tyrannical

local awful = require("awful")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile, -- default
    awful.layout.suit.fair,
    awful.layout.suit.tile.top,
    awful.layout.suit.max,
    awful.layout.suit.magnifier,
}

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag(
        {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"},
        s,
        awful.layout.suit.tile
    )
end)
