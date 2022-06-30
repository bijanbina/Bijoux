local awful = require("awful")
local naughty = require('naughty')  -- debug
local focus_timer = timer({ timeout = 0.2 })

function focusUnderMouse()
	local c = awful.mouse.client_under_pointer()
	if not (c == nil) then
		--naughty.notify({text='focusUnderMouse' .. c.name})
		c:raise()
		client.focus = c
	end
	focus_timer:stop()
end

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

function set_tag(tag)
	for s = 1, screen.count() do
		screen[s].tags[tag]:view_only()
	end
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
	
	focus_timer:connect_signal("timeout", focusUnderMouse)
	focus_timer:start()
end

function switch_screen_app(c)

	--naughty.notify({text='index: ' .. tostring(c.screen.index)})
	if c.screen.index == 1 then
		c.screen = 2
	else
		c.screen = 1
	end
	awful.screen.focus_relative(1)

end

-- Sort by x position screen number
function sort_screen()

	for i = 1, screen.count()-1 do
		local s1_x = screen[i].geometry.x
		local s2_x = screen[i+1].geometry.x
		if s1_x>s2_x then
			naughty.notify({text='screen swapped'})
			screen[i]:swap(screen[i+1])
		end
	end

	--local s1_x = screen[1].geometry.x
	--local s2_x = screen[2].geometry.x
	--naughty.notify({text='s1 ' .. tostring(s1_x)})
	--naughty.notify({text='s2 ' ..  tostring(s2_x)})

end

-- customize naughty
local nconf = naughty.config
nconf.defaults.position = "bottom_right"
