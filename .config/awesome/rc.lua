-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- Local libraries
local myutils = require("mylib/myutils")
local kbdwidget = require("mylib/kbdwidget")
local keydoc = require("mylib/keydoc")


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
	title = "Houston, we have a problem",
	text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = err })
			in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions

-- This is used later as the default cmd_terminal and editor to run.
cmd_terminal = "termite"
editor = "gvim"
cmd_editor = editor
-- Other programs
cmd_browser = "google-chrome-stable"

-- Window classes
class_browser = "google-chrome"

-- Directories
confdir = awful.util.getdir("config") .. "/"
themedir = confdir .. "themes/"

-- Themes define colours, icons, font and wallpapers.
beautiful.init(themedir .. "sky-mod.lua")

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local all_layouts =
{
	-- float:
	awful.layout.suit.floating,
	-- default tile:
	awful.layout.suit.tile,
	-- mirrored default:
	awful.layout.suit.tile.left,
	-- tiling in bottom:
	awful.layout.suit.tile.bottom,
	-- tiling on top:
	awful.layout.suit.tile.top,
	-- fair splitting:
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	-- spiral:
	awful.layout.suit.spiral,
	-- spiral to corner:
	awful.layout.suit.spiral.dwindle,
	-- one maximized client:
	awful.layout.suit.max,
	-- one fullscreen client:
	awful.layout.suit.max.fullscreen,
	-- one in center:
	awful.layout.suit.magnifier
}

-- Some helpers
function switch_layout(step)
	awful.layout.inc(all_layouts, step)
	myutils.notify( awful.layout.get(mouse.screen).name, 2 )
end
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
	for s = 1, screen.count() do
		gears.wallpaper.maximized(beautiful.wallpaper, s, true)
	end
end
-- }}}

-- {{{ Tags
-- All possible layouts defined above in all_layouts
-- Define a tag table which hold all screen tags.
tags = {
	names = { "1", "2", "3", "4", "5", "6", "7", "8", "9" },
	layouts = {
		awful.layout.suit.tile,
		awful.layout.suit.tile,
		awful.layout.suit.tile,
		awful.layout.suit.tile,
		awful.layout.suit.tile,
		awful.layout.suit.tile,
		awful.layout.suit.tile,
		awful.layout.suit.tile,
		awful.layout.suit.tile,
	}
}

for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags[s] = awful.tag(tags.names, s, tags.layouts)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
menu_awesome = {
	{ "Edit config", cmd_editor .. " " .. awesome.conffile },
	{ "Restart", awesome.restart }
}

menu_shutdown = {
	{ "Logout", awesome.quit },
	{ "Suspend", "sudo /usr/sbin/pm-suspend" },
	{ "Reboot", "sudo /sbin/shutdown -r now" }
}

menu_main = awful.menu({ items = {
		{ "Programs", "" },
		{ "Awesome", menu_awesome, beautiful.awesome_icon },
		{ "Terminal", cmd_terminal },
		{ "Shutdown", menu_shutdown }
	}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = menu_main })

-- Menubar configuration
-- Set the cmd_terminal for applications that require it
menubar.utils.cmd_terminal = cmd_terminal
-- }}}

-- {{{ Wibox

-- Create a textclock widget
-- (1 for update every second)
mytextclock = awful.widget.textclock( " <b>%a, %d %b, %H:%M:%S</b> ", 1 )

-- Wibox for conky
mystatusbar = awful.wibox({ position = "bottom", screen = 1, ontop = false, width = 1, height = 20 })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}

mytaglist = {}
mytaglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ modkey }, 1, awful.client.movetotag),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, awful.client.toggletag),
	awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
	awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
	awful.button({ }, 1, function (c)
		--Disable minimizing but allow select active client from tasklist
		--[[
		if c == client.focus then
		c.minimized = true
		else
		-- Without this, the following
		-- :isvisible() makes no sense
		c.minimized = false
		if not c:isvisible() then
		awful.tag.viewonly(c:tags()[1])
		end
		-- This will also un-minimize
		-- the client, if needed
		client.focus = c
		c:raise()
		end
		]]
		client.focus = c
		c:raise()
	end),
	awful.button({ }, 3, function()
		if instance then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({
				theme = { width = 250 }
			})
		end
	end),
	awful.button({ }, 4, function()
		awful.client.focus.byidx(1)
		if client.focus then client.focus:raise() end
	end),
	awful.button({ }, 5, function()
		awful.client.focus.byidx(-1)
		if client.focus then client.focus:raise() end
	end)
)

for s = 1, screen.count() do
	-- Create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt()
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
		awful.button({ }, 1, function() switch_layout(1) end),
		awful.button({ }, 3, function() switch_layout(-1) end),
		awful.button({ }, 4, function() switch_layout(1) end),
		awful.button({ }, 5, function() switch_layout(-1) end)
	))
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

	-- Create the wibox
	mywibox[s] = awful.wibox({ position = "top", screen = s })

	-- Widgets that are aligned to the left
	local left_layout = wibox.layout.fixed.horizontal()
	left_layout:add(mylauncher)
	left_layout:add(mytaglist[s])
	left_layout:add(mypromptbox[s])

	-- Widgets that are aligned to the right
	local right_layout = wibox.layout.fixed.horizontal()
	if s == 1 then right_layout:add(wibox.widget.systray()) end
	right_layout:add(kbdwidget.create(confdir .. "kbd-icons/"))
	right_layout:add(mytextclock)
	right_layout:add(mylayoutbox[s])

	-- Now bring it all together (with the tasklist in the middle)
	local layout = wibox.layout.align.horizontal()
	layout:set_left(left_layout)
	layout:set_middle(mytasklist[s])
	layout:set_right(right_layout)

	mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
awful.button({ }, 3, function() menu_main:toggle() end),
awful.button({ }, 4, awful.tag.viewnext),
awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings

globalkeys = awful.util.table.join(

	keydoc.group("Tags"),

	keydoc.add({ modkey,		   }, "Left",	awful.tag.viewprev,
		"Switch to the left"),
	keydoc.add({ modkey,		   }, "Right",	awful.tag.viewnext,
		"Switch to the right"),
	keydoc.add({ modkey,		   }, "Escape", awful.tag.history.restore,
		"Previous tag"),

	keydoc.group("Navigation"),

	keydoc.add({ modkey,		   }, "j",
		function()
			awful.client.focus.byidx( 1)
			if client.focus then client.focus:raise() end
		end,
		"Next window"),

	keydoc.add({ modkey,		   }, "k",
		function()
			awful.client.focus.byidx(-1)
			if client.focus then client.focus:raise() end
		end,
		"Previous window"),

	keydoc.add({ modkey, "Shift"   }, "j", function() awful.client.swap.byidx(  1)    end,
		"Swap current and next windows"),

	keydoc.add({ modkey, "Shift"   }, "k", function() awful.client.swap.byidx( -1)    end,
		"Swap current and previous windows"),

	--[[
	keydoc.add({ modkey, "Control" }, "j", function() awful.screen.focus_relative( 1) end
	"Focus next screen"),

	keydoc.add({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
	"Focus previous screen"),
	]]

	keydoc.add({ modkey,		   }, "u", awful.client.urgent.jumpto,
		"Jump to urgent"),

	keydoc.add({ modkey,		   }, "Tab",
		function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		"Previous focused window"),

	keydoc.group("Layout manipulation"),

	keydoc.add({ modkey }, "space", function() switch_layout(1) end, "Next layout"),
	keydoc.add({ modkey, "Shift" }, "space", function() switch_layout(-1) end, "Previous layout"),

	keydoc.add({ modkey,		   }, "l",	   function() awful.tag.incmwfact( 0.05)	 end,
		"Increase master width"),
	keydoc.add({ modkey,		   }, "h",	   function() awful.tag.incmwfact(-0.05)	 end,
		"Decrease master width"),
	keydoc.add({ modkey, "Shift"   }, "h",	   function() awful.tag.incnmaster( 1)		 end,
		"Increase number of master windows"),
	keydoc.add({ modkey, "Shift"   }, "l",	   function() awful.tag.incnmaster(-1)		 end,
		"Decrease number of master windows"),
	keydoc.add({ modkey, "Control" }, "h",	   function() awful.tag.incncol( 1)		 end,
		"Increase non-master columns"),
	keydoc.add({ modkey, "Control" }, "l",	   function() awful.tag.incncol(-1)		 end,
		"Decrease non-master columns"),

	keydoc.group("Launch programs"),

	keydoc.add({ modkey },			  "r",	   function() myutils.run_once("gmrun") end,
		"Execute any program"),

	keydoc.add({ modkey }, "p", function() menubar.show() end,
		"Show menubar"),

	keydoc.add({ modkey,		   }, "Return", function() awful.util.spawn(cmd_terminal) end,
		"Terminal"),

	-- Start browser and switch to tag (hardcoded)
	keydoc.add({ modkey }, "w",
		function()
			-- run_or_raise selects wrong window when multiple of them opened
			-- awful.client.run_or_raise(cmd_browser, function(c) return c.class == class_browser end, false)
			chrome = awful.client.iterate(function(c) return c.class == class_browser end)()
			if chrome == nil then
				myutils.exec(cmd_browser)
			end
			awful.tag.viewonly(tags[1][2])
		end,
		"Browser"),

	-- File manager
	keydoc.add({ modkey }, "e", function() myutils.exec("spacefm") end,
		"File manager"),

	keydoc.group("Misc"),

	keydoc.add({ modkey,		   }, "a", function() menu_main:show() end,
		"Awesome menu"),

	-- Screen locking
	keydoc.add({ modkey }, "F12", function() myutils.exec("xtrlock") end,
		"Lock screen"),

	keydoc.add({ modkey }, "x",
		function()
			awful.prompt.run({ prompt = "Run Lua code: " },
			mypromptbox[mouse.screen].widget,
			awful.util.eval, nil,
			awful.util.getdir("cache") .. "/history_eval")
		end,
		"Run Lua code"),

	-- Screenshots
	keydoc.add({ }, "Print", function() myutils.exec("screengrab --fullscreen") end,
		"Screenshot"),
	keydoc.add({ "Ctrl" }, "Print", function() myutils.exec("screengrab --active") end,
		"Screenshot (window)"),
	keydoc.add({ "Shift" }, "Print", function() myutils.exec("screengrab --region") end,
		"Screenshot (selection"),

	-- Hotkeys help
	keydoc.add({ modkey }, "/", function() keydoc.display() end,
		"This help")

) -- globalkeys end

clientkeys = awful.util.table.join(

	keydoc.group("Windows"),

	keydoc.add({ modkey			  }, "f",	   function (c) c.fullscreen = not c.fullscreen  end,
		"Toggle fullscreen"),

	keydoc.add({ modkey			  }, "c",	   function (c) c:kill() end,
		"Close window"),

--	keydoc.add({ modkey, "Shift"   }, "c",		function (c) myutils.exec("xkill -id " .. c.window) end,
	keydoc.add({ modkey, "Shift"   }, "c",		function (c) myutils.exec("xkill") end,
		"Execute xkill"),

	keydoc.add({ modkey, "Control" }, "space",	awful.client.floating.toggle,
		"Toggle floating status"),

	keydoc.add({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
		"Swap current with master"),

	--	  keydoc.add({ modkey,			 }, "o",	  awful.client.movetoscreen						   ),

	keydoc.add({ modkey,		   }, "t",		function (c) c.ontop = not c.ontop			  end,
		"Toggle on-top status"),

	-- Disable minimizing
	--[[keydoc.add({ modkey,		   }, "n",
	function (c)
	-- The client currently has the input focus, so it cannot be
	-- minimized, since minimized clients can't have the focus.
	c.minimized = true
	end), ]]

	keydoc.add({ modkey,		   }, "m",
		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c.maximized_vertical   = not c.maximized_vertical
		end,
		"(Un)maximize window")

)

-- Bind all key numbers to tags.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = awful.util.table.join(globalkeys,

		keydoc.group("Tags"),

		-- View tag only.
		keydoc.add({ modkey }, "#" .. i + 9,
		function()
			local screen = mouse.screen
			local tag = awful.tag.gettags(screen)[i]
			if tag then
				awful.tag.viewonly(tag)
			end
		end,
		-- "i == 5" because of hardcoded translation "#14" to "#" in keydoc.lua
		i == 5 and "View tag # only" or nil),

		-- Toggle tag.
		keydoc.add({ modkey, "Control" }, "#" .. i + 9,
		function()
			local screen = mouse.screen
			local tag = awful.tag.gettags(screen)[i]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
		i == 5 and "Toggle tag # view" or nil),

		-- Move client to tag.
		keydoc.add({ modkey, "Shift" }, "#" .. i + 9,
		function()
			if client.focus then
				local tag = awful.tag.gettags(client.focus.screen)[i]
				if tag then
					awful.client.movetotag(tag)
				end
			end
		end,
		i == 5 and "Set tag # for window" or nil),

		-- Toggle tag.
		keydoc.add({ modkey, "Control", "Shift" }, "#" .. i + 9,
		function()
			if client.focus then
				local tag = awful.tag.gettags(client.focus.screen)[i]
				if tag then
					awful.client.toggletag(tag)
				end
			end
		end,
		i == 5 and "Toggle tag # on window" or nil)

	)
end

clientbuttons = awful.util.table.join(
	awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {

	-- All clients will match this rule.
	{ rule = { },
		properties = { border_width = beautiful.border_width,
		border_color = beautiful.border_normal,
		focus = awful.client.focus.filter,
		size_hints_honor = false,
		raise = true,
		keys = clientkeys,
		buttons = clientbuttons }
	},

	{ rule = { class = "Xgame-gtk2" },
		properties = { floating = true }
	},

	--[[	{ rule = { class = "Conky" },
	properties = {
	floating = true,
	sticky = true,
	ontop = false,
	focusable = false }
	}, ]]

	-- Prevent gmrun hiding
	{ rule = { class = "Gmrun" },
		properties = {
		ontop = true,
		sticky = true }
	},

	{ rule = { class = "Screengrab" },
		properties = {
		floating = true,
		ontop = true,
		sticky = true }
	},

	-- Set Chrome to always map on tags number 2 of screen 1.
	{ rule = { class = class_browser },
		properties = { tag = tags[1][2] }
	},

} -- Rules end
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
	-- Enable sloppy focus
	c:connect_signal("mouse::enter", function(c)
		if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
			-- Workaround for prevent easy getting focus by conky
			and c.class ~= "Conky" and awful.client.focus.filter(c) then
			client.focus = c
		end
	end)

	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		-- awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end

	local titlebars_enabled = false
	if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
		-- buttons for the titlebar
		local buttons = awful.util.table.join(
		awful.button({ }, 1, function()
			client.focus = c
			c:raise()
			awful.mouse.client.move(c)
		end),
		awful.button({ }, 3, function()
			client.focus = c
			c:raise()
			awful.mouse.client.resize(c)
		end)
		)

		-- Widgets that are aligned to the left
		local left_layout = wibox.layout.fixed.horizontal()
		left_layout:add(awful.titlebar.widget.iconwidget(c))
		left_layout:buttons(buttons)

		-- Widgets that are aligned to the right
		local right_layout = wibox.layout.fixed.horizontal()
		right_layout:add(awful.titlebar.widget.floatingbutton(c))
		right_layout:add(awful.titlebar.widget.maximizedbutton(c))
		right_layout:add(awful.titlebar.widget.stickybutton(c))
		right_layout:add(awful.titlebar.widget.ontopbutton(c))
		right_layout:add(awful.titlebar.widget.closebutton(c))

		-- The title goes in the middle
		local middle_layout = wibox.layout.flex.horizontal()
		local title = awful.titlebar.widget.titlewidget(c)
		title:set_align("center")
		middle_layout:add(title)
		middle_layout:buttons(buttons)

		-- Now bring it all together
		local layout = wibox.layout.align.horizontal()
		layout:set_left(left_layout)
		layout:set_right(right_layout)
		layout:set_middle(middle_layout)

		awful.titlebar(c):set_widget(layout)
	end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

--}}}

-- {{{ Autostart
-- Some things should be launched when Awesome is already active
local cmds = {
--myxkbmap", -- Replaced by system-wide settings in xorg.conf
	"conky -c ~/.conky/conkybar",
	"fuck_wibox",
}

for _,cmd in pairs(cmds) do
	myutils.run_once(cmd)
end
-- }}}

