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
