-------------------------------
--    "Sky" awesome theme    --
--  By Andrei "Garoth" Thorp --
-------------------------------
-- If you want SVGs and extras, get them from garoth.com/awesome/sky-theme
local fs = require("gears.filesystem")

local themedir = fs.get_themes_dir()
local default_theme = themedir .. "/default"
local sky_theme = themedir .. "/sky"

-- BASICS
local theme = {}
theme.font = "sans 10"

theme.bg_focus = "#e2eeea"
theme.bg_normal = "#729fcf"
theme.bg_urgent = "#fce94f"
theme.bg_minimize = "#0067ce"
theme.bg_systray = theme.bg_normal

theme.fg_normal = "#2e3436"
theme.fg_focus = "#2e3436"
theme.fg_urgent = "#2e3436"
theme.fg_minimize = "#2e3436"

theme.useless_gap = 0
theme.border_width = 2
theme.border_normal = "#dae3e0"
theme.border_focus = "#729fcf"
theme.border_marked = "#eeeeec"

-- IMAGES
theme.layout_fairh = sky_theme .. "/layouts/fairh.png"
theme.layout_fairv = sky_theme .. "/layouts/fairv.png"
theme.layout_floating = sky_theme .. "/layouts/floating.png"
theme.layout_magnifier = sky_theme .. "/layouts/magnifier.png"
theme.layout_max = sky_theme .. "/layouts/max.png"
theme.layout_fullscreen = sky_theme .. "/layouts/fullscreen.png"
theme.layout_tilebottom = sky_theme .. "/layouts/tilebottom.png"
theme.layout_tileleft = sky_theme .. "/layouts/tileleft.png"
theme.layout_tile = sky_theme .. "/layouts/tile.png"
theme.layout_tiletop = sky_theme .. "/layouts/tiletop.png"
theme.layout_spiral = sky_theme .. "/layouts/spiral.png"
theme.layout_dwindle = sky_theme .. "/layouts/dwindle.png"
theme.layout_cornernw = sky_theme .. "/layouts/cornernw.png"
theme.layout_cornerne = sky_theme .. "/layouts/cornerne.png"
theme.layout_cornersw = sky_theme .. "/layouts/cornersw.png"
theme.layout_cornerse = sky_theme .. "/layouts/cornerse.png"

theme.awesome_icon = sky_theme .. "/awesome-icon.png"

-- from default for now...
theme.menu_submenu_icon = default_theme .. "/submenu.png"
theme.taglist_squares_sel = default_theme .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = default_theme .. "/taglist/squarew.png"

-- MISC
theme.wallpaper = function(s)
    default_wp = sky_theme .. "/sky-background.png"
    custom_wp = fs.get_xdg_config_home() .. "wallpaper"
    if fs.file_readable(custom_wp) then
        return custom_wp
    else
        return default_wp
    end
end

theme.taglist_squares = "true"
theme.titlebar_close_button = "true"
theme.menu_height = 20
theme.menu_width = 150
theme.maximized_hide_border = true

-- Define the image to load
theme.titlebar_close_button_normal = default_theme .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus = default_theme .. "/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = default_theme .. "/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus = default_theme .. "/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = default_theme .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive = default_theme .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = default_theme .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active = default_theme .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = default_theme .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive = default_theme .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = default_theme .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active = default_theme .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = default_theme .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive = default_theme .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = default_theme .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active = default_theme .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = default_theme .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive = default_theme .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = default_theme .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active = default_theme .. "/titlebar/maximized_focus_active.png"

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
