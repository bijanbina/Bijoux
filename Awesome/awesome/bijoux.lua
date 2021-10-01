local awful = require("awful")

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
	awful.tag.viewnext(screen[1])
	awful.tag.viewnext(screen[2])
end

function tag_prev() 
	awful.tag.viewprev(screen[1])
	awful.tag.viewprev(screen[2])
end

function tag_history() 
	awful.tag.history.restore(screen[1])
	awful.tag.history.restore(screen[2])
end

-- customize naughty
local naughty = require("naughty")
local nconf = naughty.config
nconf.defaults.position = "bottom_right"
