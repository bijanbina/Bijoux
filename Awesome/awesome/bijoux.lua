local awful = require("awful")
local naughty = require('naughty')  -- notification

function spawn_tag(command, tag) 
  -- create move callback
	local callback 
	callback = function(c) 
		c:move_to_tag(tag)
		client.disconnect_signal("manage", callback) 
	end 
	client.connect_signal("manage", callback) 
	
	awful.util.spawn_with_shell(command)
end

function tag_next()
	for s = 1, screen.count() do
		awful.tag.viewnext(screen[s])
	end
end

function tag_prev()
	for s = 1, screen.count() do
		awful.tag.viewprev(screen[s])
	end
end

function tag_history()
	for s = 1, screen.count() do
		awful.tag.history.restore(screen[s])
	end
end

function switch_screen()
	-- naughty.notify({text='some message'})
	local c1
	local c2
	for s = 1, screen.count() do
		if s == 1 then
			c1 = screen[s]:get_clients()
		else
			c2 = screen[s]:get_clients()
		end
	end

	-- local msg = "c1 " .. v.name
	-- naughty.notify({text=msg})
	-- % used to escape -, hyphen is a special char in lua
	for k, v in pairs(c1) do
		if not v.name:find("polybar%-bbar") then
			v.screen = 2
		end
	end

	for k, v in pairs(c2) do
		if not v.name:find("polybar%-bbar") then
			v.screen = 1
		end
	end
end

-- customize naughty
local nconf = naughty.config
nconf.defaults.position = "bottom_right"
