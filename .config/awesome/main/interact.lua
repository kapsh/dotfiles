local awful = require("awful")
local gtable = require("gears.table")
local hotkeys_popup = require("awful.hotkeys_popup")
local poppin = require("poppin")

local modkey = RC.settings.modkey

-- xorg mouse buttons numbering
-- TODO already defined somewhere?
local mb = {
    any = 0,
    left = 1,
    right = 3,
    middle = 2,
    scroll_up = 4,
    scroll_down = 5,
    scroll_left = 6,
    scroll_right = 7,
}

local interact = {}

interact.taglist_buttons = gtable.join(
    awful.button({}, mb.left, function(t)
        t:view_only()
    end),
    awful.button({modkey}, mb.left, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, mb.right, awful.tag.viewtoggle),
    awful.button({modkey}, mb.right, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, mb.scroll_up, function(t)
        awful.tag.viewprev(t.screen)
    end),
    awful.button({}, mb.scroll_down, function(t)
        awful.tag.viewnext(t.screen)
    end)
)

interact.tasklist_buttons = gtable.join(
    awful.button({}, mb.left, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end),
    awful.button({}, mb.right, function()
        awful.menu.client_list({theme = {width = 500}})
    end),
    awful.button({}, mb.scroll_up, function()
        awful.client.focus.byidx(-1)
    end),
    awful.button({}, mb.scroll_down, function()
        awful.client.focus.byidx(1)
    end)
)

-- TODO refactor by group: basic manage, launch apps, etc.
local global_keys = gtable.join(

    awful.key({ modkey, "Shift" }, "/", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),

    awful.key({ modkey, }, "Left", awful.tag.viewprev,
        { description = "view previous", group = "tags" }),

    awful.key({ modkey, }, "Right", awful.tag.viewnext,
        { description = "view next", group = "tags" }),

    awful.key({ modkey, }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tags" }),

    awful.key({ modkey, }, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}
    ),

    awful.key({ modkey, }, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation

    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),

    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),

    awful.key({ modkey, }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),

    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}
    ),

    -- Switching active screen

    awful.key({ modkey, }, "s", function() awful.screen.focus_relative(1) end,
        { description = "focus the next screen", group = "screen" }),

    awful.key({ modkey, "Shift" }, "s", function() awful.screen.focus_relative(-1) end,
        { description = "focus the previous screen", group = "screen" }),

    -- Standard program

    awful.key({ modkey, }, "Return", function() awful.spawn(RC.settings.terminal) end,
        { description = "open terminal", group = "launcher" }),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),

    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),

    -- More layout manipulation

    awful.key({ modkey, }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),

    awful.key({ modkey, }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),

    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase the number of master clients", group = "layout" }),

    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease the number of master clients", group = "layout" }),

    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase the number of columns", group = "layout" }),

    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease the number of columns", group = "layout" }),

    awful.key({ modkey, }, "space", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),

    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
        { description = "select previous", group = "layout" }),

    awful.key({ modkey, "Control" }, "n",
        function ()
            local c = awful.client.restore()
            -- Focus restored client
            if c then
                c:emit_signal("request::activate", "key.unminimize", {raise = true})
            end
        end,
        {description = "restore minimized", group = "client"}
    ),

    -- Zim
    awful.key({ modkey }, "z", function() awful.spawn("zim") end,
        { description = "open zim", group = "launcher" }),

    -- Clipboard manager
    awful.key({ modkey }, "v", function() awful.spawn("copyq show") end,
        { description = "clipboard history", group = "launcher" }),

    -- Screen lock
    awful.key({ modkey }, "F12", function() awful.spawn("xscreensaver-command -lock") end,
        { description = "lock screen", group = "launcher" }),

    -- ipython
    awful.key({ modkey }, "a",
        function()
            poppin.pop(
                "ipython console",
                "jupyter-qtconsole",
                "center",
                { titlebars_enabled = true, skip_taskbar = true }
            )
        end,
        {description = "ipython console", group = "launcher"}
    )

)

local app_launchers = gtable.join(
    awful.key({ modkey }, "/", function() awful.spawn("rofi -modi window -show window") end,
        { description = "windows", group = "launcher" }),

    awful.key({ modkey }, "r", function() awful.spawn("rofi -modi run,drun -show run") end,
        { description = "run...", group = "launcher" }),

    awful.key({ modkey }, "p", function() awful.spawn("rofi -modi run,drun -show drun") end,
        { description = "run desktop file...", group = "launcher" }),

    awful.key({ modkey, "Shift" }, "r", function () awful.screen.focused().mypromptbox:run() end,
        {description = "run prompt", group = "launcher"})
)

local function keycode(n)
    return "#" .. n + 9
end

local function tag_bindings(tagnum)
    local add_help = tagnum == 1

    return gtable.join(
    -- View tag only.
    awful.key({ modkey }, keycode(tagnum),
    function()
        local screen = awful.screen.focused()
        local tag = screen.tags[tagnum]
        if tag then
            tag:view_only()
        end
    end,
    add_help and { description = "view tag #n", group = "tags" }),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, keycode(tagnum),
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[tagnum]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            add_help and { description = "toggle tag #n", group = "tags" }),

        -- Move client to tag.
        awful.key({ modkey, "Shift" },keycode(tagnum),
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[tagnum]
                    if tag then
                        client.focus:move_to_tag(tag)
                    end
                end
            end,
            add_help and { description = "move focused client to tag #n", group = "tags" }),

        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, keycode(tagnum),
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[tagnum]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            add_help and {description = "toggle focused client on tag #n", group = "tags"}
        )
        )
end

for i = 1, 10 do -- TODO 10 is 0
    global_keys = gtable.join( global_keys, tag_bindings(i))
end

global_keys = gtable.join(
    app_launchers,
    global_keys
)

interact.global_keys = global_keys

interact.global_buttons=gtable.join(
    awful.button({}, mb.right, function()
        mymainmenu:toggle()
    end),
    awful.button({}, mb.scroll_up, awful.tag.viewprev),
    awful.button({}, mb.scroll_down, awful.tag.viewnext)
)

interact.client_buttons = gtable.join(
    awful.button({}, mb.left, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),

    awful.button({modkey}, mb.left, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),

    awful.button({modkey}, mb.right, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

interact.client_keys = gtable.join(
    awful.key({ modkey, }, "f",
    function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end,
    { description = "toggle fullscreen", group = "client" }),

    awful.key({ modkey, }, "c", function(c) c:kill() end,
        { description = "close", group = "client" }),

    awful.key({ modkey, "Shift" }, "c", function() awful.spawn("xkill") end,
        { description = "kill", group = "client" }),

    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),

    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),

    awful.key({ modkey, }, "o", function(c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }),

    awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end,
        { description = "toggle keep on top", group = "client" }),

    awful.key({ modkey, }, "n",
        function(c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "client"}
    ),

    awful.key({ modkey, }, "m",
        function(c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    ),

    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end,
        {description = "(un)maximize vertically", group = "client"}
    ),

    awful.key({ modkey, "Shift" }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end,
        {description = "(un)maximize horizontally", group = "client"}
    )
)

interact.layoutbox_buttons = gtable.join(
        awful.button({}, mb.left, function()
            awful.layout.inc(1)
        end),
        awful.button({}, mb.right, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, mb.scroll_up, function()
            awful.layout.inc(1)
        end),
        awful.button({}, mb.scroll_down, function()
            awful.layout.inc(-1)
        end)
    )

return interact
