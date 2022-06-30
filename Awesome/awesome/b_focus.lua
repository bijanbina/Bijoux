local awful = require("awful")
local naughty = require('naughty')  -- debug

local client = client
local aclient = require("awful.client")
local timer = require("gears.timer")

local function filter_sticky(c)
    return not c.sticky and aclient.focus.filter(c)
end

--- Give focus when clients appear/disappear.
--
-- @param obj An object that should have a .screen property.
local function check_focus(obj)
    if (not obj.screen) or not obj.screen.valid then return end
    -- When no visible client has the focus...
    if not client.focus or not client.focus:isvisible() then
        local c = aclient.focus.history.get(screen[obj.screen], 0, filter_sticky)
        if not c then
            c = aclient.focus.history.get(screen[obj.screen], 0, aclient.focus.filter)
        end
        if c then
            c:emit_signal("request::activate", "autofocus.check_focus",
                          {raise=false})
        end
    end
end

--- Check client focus (delayed).
-- @param obj An object that should have a .screen property.
local function check_focus_delayed(obj)
    timer.delayed_call(check_focus, {screen = obj.screen})
end

--tag.connect_signal("property::selected", function (t)
--    timer.delayed_call(check_focus_tag, t)
--end)
client.connect_signal("unmanage",            check_focus_delayed)
--client.connect_signal("tagged",              check_focus_delayed)
--client.connect_signal("untagged",            check_focus_delayed)
client.connect_signal("property::hidden",    check_focus_delayed)
client.connect_signal("property::minimized", check_focus_delayed)
client.connect_signal("property::sticky",    check_focus_delayed)