local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
require("bijoux")

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey,    }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey,    }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "u",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

qt_clientkeys = awful.util.table.join(
    clientkeys,
    awful.key({ }, "KP_Subtract", function ()
			  awful.spawn.with_shell("~/.config/awesome/keymap.sh qt_find")
			  end),

    -- Refractor
    awful.key({ }, "KP_Divide", function ()
              awful.spawn.with_shell("~/.config/awesome/keymap.sh qt_refractor")
              end, {description = "Copy", group = "launcher"}),

    -- Valgrind
    awful.key({ }, "KP_Multiply", function ()
              awful.spawn.with_shell("~/.config/awesome/keymap.sh valgrind")
              end, {description = "valgrind", group = "launcher"})
)

mx_clientkeys = awful.util.table.join(
    clientkeys,
    -- awful.key({ }, " ", function () awful.spawn.with_shell("~/.config/awesome/keymap_mx.sh change") end),
    awful.key({ }, "Right", function () awful.spawn.with_shell("~/.config/awesome/keymap_mx.sh right") end),
    awful.key({ }, "Down", function () awful.spawn.with_shell("~/.config/awesome/keymap_mx.sh down") end)
)

vscode_clientkeys = awful.util.table.join(
    clientkeys,
    awful.key({ }, "KP_Divide", function ()
    awful.spawn.with_shell("~/.config/awesome/keymap_vscode.sh 1")
    end),
    awful.key({ }, "KP_Multiply", function ()
    awful.spawn.with_shell("~/.config/awesome/keymap_vscode.sh 2")
    end)
)

chess_clientkeys = awful.util.table.join(
    clientkeys,
    awful.key({ }, "Right", function (c) switch_screen_app(c) end),
    awful.key({ }, "Left", function (c) switch_screen_app(c) end)
)
