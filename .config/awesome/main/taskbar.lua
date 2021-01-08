local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")

local myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "edit config", RC.settings.editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
local mymainmenu = awful.menu({
    items = {
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "terminal", RC.settings.terminal }
    }
})
local menubutton = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag({"1", "2", "3", "4", "5", "6", "7", "8", "9", "0"}, s, awful.layout.layouts[2])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt() -- used for run prompt
    local layoutindicator = awful.widget.layoutbox(s)
    layoutindicator:buttons(RC.interact.layoutbox_buttons)
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = RC.interact.taglist_buttons
    }
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, RC.interact.tasklist_buttons)

    local mywibox = awful.wibar({position = "top", screen = s})
    mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            menubutton,
            s.mytaglist,
            s.mypromptbox,
        },
        -- Middle widget
        s.mytasklist,
        {
            -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            awful.widget.keyboardlayout(),
            wibox.widget.systray(),
            wibox.widget.textclock(RC.settings.clock_format, 1),
            layoutindicator,
        },
    }
end)
