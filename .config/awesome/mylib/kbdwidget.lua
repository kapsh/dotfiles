local wibox = require("wibox")
local beautiful = require("beautiful")
local dbus = dbus

module("kbdwidget")

local kbdwidget = {}

function kbdwidget.create(icondir)

	-- Layout indicator's icons
	kbdlayout_en = icondir .. "en.png"
	kbdlayout_ru = icondir .. "ru.png"

	local layoutbox = wibox.widget.imagebox(kbdlayout_en)
	layoutbox.border_width = 0
	layoutbox.border_color = beautiful.fg_normal
	layoutbox.bg_align = "center"
	layoutbox.width = 20
	layoutbox.set_resize = true

	-- Listening kbdd for layout changing events
	dbus.request_name("session", "ru.gentoo.kbdd")
	dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
	dbus.connect_signal("ru.gentoo.kbdd", function(...)
		local data = {...}
		local layout = data[2]
		if layout == 0 then
			layoutbox:set_image(kbdlayout_en)
		else
			layoutbox:set_image(kbdlayout_ru)
		end
	end )

	return layoutbox

end

return kbdwidget
