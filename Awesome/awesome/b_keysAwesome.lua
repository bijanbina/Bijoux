local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")


local focus_timer = timer({ timeout = 0.2 })

function focusUnderMouse()
	local c = awful.mouse.client_under_pointer()
	if not (c == nil) then
		client.focus = c
		c:raise()
	end
	focus_timer:stop()
end

-- Tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 6 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
						for s = 1, screen.count() do
		                    local tag = screen[s].tags[i]
		                    if tag then
		                       tag:view_only()
		                    end
						end
						focus_timer:connect_signal("timeout", focusUnderMouse)
						focus_timer:start()
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end),
    awful.button({ modkey }, 2, tag_next),
    awful.button({ modkey }, 4, tag_prev),
    awful.button({ modkey }, 5, tag_next),
    awful.button({ modkey, "Shift" }, 4, function (c)
        awful.tag.viewprev(awful.screen.focused())
    end),
    awful.button({ modkey, "Shift" }, 5, function (c)
        awful.tag.viewnext(awful.screen.focused())
    end)
)