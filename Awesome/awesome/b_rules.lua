local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require('naughty')

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
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     callback = function (c)
                         c:struts({top = 25})
                     end
     }
    },
    
    { rule = { class = "Polybar" },
      properties = { border_width = 0,
                     raise = true }
    },

    { rule = { class = "PnaUI" },
      properties = { border_width = 0,
                     floating = true,
                     tag = screen[1].tags[3],
                     placement = awful.placement.centered
                   }
    },

    { rule = { class = "Chess" },
      properties = { border_width = 0,
	  				 keys = chess_clientkeys,
					 ontop = true,
                     callback = function (c)
						 c.maximized = true
                     end
                   }
    },
    
    { rule = { class = "Nxplayer.bin" },
      properties = { keys = mx_clientkeys,
                     callback = function (c)
                         c.fullscreen = true
                     end
                   }
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
