local awful = require("awful")
local beautiful = require("beautiful")

qt_clientkeys = awful.util.table.join(
    clientkeys,
    awful.key({ }, "KP_Subtract", function ()
			  awful.spawn.with_shell("~/.config/awesome/keymap.sh qt_find")
			  end),

    -- Continue(Debug)
    awful.key({ }, "KP_Add", function ()
              awful.spawn.with_shell("~/.config/awesome/keymap.sh qt_continue")
              end, {description = "Copy", group = "launcher"}),

    -- Restart Debugger
    awful.key({ }, "KP_Multiply", function ()
              awful.spawn.with_shell("~/.config/awesome/keymap.sh qt_restart")
              end, {description = "Copy", group = "launcher"}),

    -- Refractor
    awful.key({ }, "KP_Divide", function ()
              awful.spawn.with_shell("~/.config/awesome/keymap.sh qt_refractor")
              end, {description = "Copy", group = "launcher"})
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


awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },
    
    { rule = { class = "Polybar" },
      properties = { border_width = 0 }
    },
    
    { rule = { class = "QtCreator" },
      properties = { keys = qt_clientkeys }
    },
    
    { rule = { class = "code-oss" },
      properties = { keys = vscode_clientkeys }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
