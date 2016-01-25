local naughty = require("naughty")
local awful = require("awful")
local io = require("io")
local timer = timer
local tonumber = tonumber

module("myutils")

myutils = {}

-- Show notification
function myutils.notify(message, timeout)
	if timeout == nil then
		timeout = 10
	end
	naughty.notify( { text = message, timeout } )
end

function myutils.notify_error(message, timeout)
	naughty.notify( { text = message, timeout = 10, preset = naughty.config.presets.critical } )
end

-- Execute given program or show error
function myutils.exec(cmd)
	local result = awful.util.spawn(cmd)
	-- If cmd spawned succesfully - result = PID
	-- else result = error message
	if tonumber(result) == nil then
		myutils.notify_error(result)
	end
end

function myutils.run_once(cmd)
	findme = cmd
	firstspace = cmd:find(" ")
	if firstspace then
		findme = cmd:sub(0, firstspace-1)
	end
	awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- https://awesome.naquadah.org/wiki/Run_commands_in_background

background_timers = {}

function myutils.run_background(cmd,funtocall)
	local r = io.popen("mktemp")
	local logfile = r:read("*line")
	r:close()

	cmdstr = cmd .. " &> " .. logfile .. " & "
	local cmdf = io.popen(cmdstr)
	cmdf:close()
	background_timers[cmd] = {
		file  = logfile,
		timer = timer{timeout=1}
	}
	background_timers[cmd].timer:connect_signal("timeout",function()
		local cmdf = io.popen("pgrep -f '" .. cmd .. "'")
		local s = cmdf:read("*all")
		cmdf:close()
		if (s=="") then
			background_timers[cmd].timer:stop()
			local lf = io.open(background_timers[cmd].file)
			funtocall(lf:read("*all"))
			lf:close()
			io.popen("rm " .. background_timers[cmd].file)
		end
	end)
	background_timers[cmd].timer:start()
end

return myutils
