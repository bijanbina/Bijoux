local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey, "Shift"   }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Up",   function () 
              require('awful'); screen[1].tags[4]:view_only()
              require('awful'); screen[2].tags[4]:view_only() end,
              {description = "view tag 4", group = "tag"}),
    awful.key({ modkey,           }, "Right",  tag_next,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Left",   tag_prev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Tab", tag_history,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j",
                function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", 
              group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", 
              function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", 
              group = "client"}),
    awful.key({ modkey, "Control" }, "j",
                function () awful.screen. focus_relative( 1) end,
               {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, }, "b", 
              function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", 
              group = "screen"}),
    awful.key({ modkey, }, "grave",
        function ()
            -- awful.client.focus.history.previous()
            local t_index = client.focus.first_tag.index
            local tag = client.focus.screen.tags[(t_index-2)%5 + 1]
            client.focus:move_to_tag(tag)
            -- if client.focus then
            --    client.focus:raise()
            -- end
        end,
        {description = "put client to prev tag", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Firefox
    awful.key({ modkey }, "d", function () awful.util.spawn("firefox --remote-debugging-port") end,
              {description = "launch firefox", group = "launcher"}),

    -- Nautilus
    awful.key({ modkey }, "e", function () awful.util.spawn("nautilus") end,
              {description = "launch nautilus", group = "launcher"}),

    -- Gedit
    awful.key({ modkey }, "g", function ()
     		  awful.util.spawn("xed") end,
              {description = "launch xed", group = "launcher"}),

    -- Benjamin
    awful.key({ modkey }, "i", function() awful.spawn.with_shell("~/.config/awesome/launcher.sh benjamin") end,
              {description = "launch git commit for benjamin", group = "launcher"}),

    -- Telegram
    awful.key({ modkey }, "t", function ()
				awful.spawn.with_shell("~/.config/awesome/launcher.sh telegram") end,
              {description = "launch telegram", group = "launcher"}),

    -- Spotify
    awful.key({ modkey }, "s", function ()
				awful.spawn.with_shell("~/.config/awesome/launcher.sh spotify") end,
              {description = "launch Spotify", group = "launcher"}),

    -- Qt Creator
    awful.key({ modkey }, "p", function() awful.spawn.with_shell("/mnt/sdb6/Softwares/Qt/Tools/QtCreator/bin/qtcreator") end,
              {description = "launch qt", group = "launcher"}),

    -- VS Code
    awful.key({ modkey }, "y", function ()
     		  awful.util.spawn("code") end,
              {description = "launch VS Code", group = "launcher"}),

    -- Roofi
    awful.key({ modkey }, "v",  function ()
              awful.spawn.with_shell("~/.config/rofi/launcher.sh") end,
              {description = "run prompt", group = "launcher"}),
    
	-- GitKraken
	awful.key({ modkey }, "w", function () awful.spawn.with_shell("gitkraken") end,
              {description = "launch GitKraken", group = "launcher"}),

    -- Switch Screen
    awful.key({ modkey }, "x", function () switch_screen() end,
              {description = "switch screen", group = "awesome"}),

    -- Qt Creator
    awful.key({ modkey }, "Insert", function ()
				awful.spawn.with_shell("~/.config/awesome/launcher.sh qt") end,
              {description = "launch Qt Creator", group = "launcher"}),

    -- Kaldi Nato
    awful.key({ modkey }, "Delete", function ()
				awful.spawn.with_shell("~/.config/awesome/launcher.sh kaldi") end,
              {description = "launch Kaldi Development", group = "launcher"}),

    -- Bijoux Awesome
    awful.key({ modkey }, "Home", function ()
				awful.spawn.with_shell("~/.config/awesome/launcher.sh bijoux") end,
              {description = "launch Bijoux Development", group = "launcher"}),

    -- Bijoux Meld
    awful.key({ modkey }, "End", function ()
				awful.spawn.with_shell("~/.config/awesome/launcher.sh meld") end,
              {description = "launch Meld on Awesome", group = "launcher"}),

    -- Screen Shot
    awful.key({ }, "Print", function () awful.util.spawn("scrot -d 2 -s -e 'xclip -selection clipboard -t image/png -i $f'") end,
              {description = "Take a Screenshot", group = "launcher"}),

    -- Suspend
    awful.key({ }, "Pause", function () awful.spawn.with_shell("systemctl suspend") end,
              {description = "Suspend system", group = "launcher"})
)
