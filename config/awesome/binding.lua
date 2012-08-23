local exec = awful.util.spawn

globalkeys = awful.util.table.join(
    awful.key({modkey}, "Left", awful.tag.viewprev),
    awful.key({modkey}, "Right", awful.tag.viewnext),
    awful.key({modkey}, "Escape", awful.tag.history.restore),
    awful.key({modkey, "Shift"}, "u", awesome.restart),
    awful.key({modkey}, "u", awful.client.urgent.jumpto),
    awful.key({modkey, "Control"}, "n", awful.client.restore),

    -- Standard program
    awful.key({modkey}, "Return", function()
        exec("x-terminal-emulator")
    end),
    awful.key({modkey}, "p", function()
        exec("kupfer")
    end),
    awful.key({modkey}, "e", function()
        exec("pcmanfm")
    end),
    awful.key({modkey}, "l", function()
        exec("xautolock -locknow")
    end),
    awful.key({modkey}, "n", function()
        exec("zim")
    end),

    -- Window manipulation
    awful.key({modkey}, "s", function()
        awful.client.focus.byidx(1)
        if client.focus then
            client.focus:raise()
        end
    end),
    awful.key({modkey}, "t", function()
        awful.client.focus.byidx(-1)
        if client.focus then
            client.focus:raise()
        end
    end),

    -- Screen manipulation
    awful.key({modkey, "Control"}, "s", function()
        awful.screen.focus_relative(1)
    end),
    awful.key({modkey, "Control"}, "t", function()
        awful.screen.focus_relative(-1)
    end),
    awful.key({modkey}, "Tab", function()
        awful.screen.focus_relative(1)
    end),

    -- Layout selection
    awful.key({modkey}, "space", function()
        awful.layout.inc(layouts, 1)
    end),
    awful.key({modkey, "Shift"}, "space", function()
        awful.layout.inc(layouts, -1)
    end),

    -- Layout manipulation
    awful.key({modkey, "Shift"}, "s", function()
        awful.client.swap.byidx(1)
    end),
    awful.key({modkey, "Shift"}, "t", function()
        awful.client.swap.byidx(-1)
    end),

    -- Layout resizing
    awful.key({modkey}, "c", function()
        awful.tag.incmwfact(0.05)
    end),
    awful.key({modkey}, "r", function()
        awful.tag.incmwfact(-0.05)
    end),
    awful.key({modkey, "Shift"}, "c", function()
        awful.tag.incnmaster(1)
    end),
    awful.key({modkey, "Shift"}, "r", function()
        awful.tag.incnmaster(-1)
    end),
    awful.key({modkey, "Control"}, "c", function()
        awful.tag.incncol(1)
    end),
    awful.key({modkey, "Control"}, "r", function()
        awful.tag.incncol(-1)
    end)
)

clientkeys = awful.util.table.join(
    awful.key({modkey}, "f", function(c)
        c.fullscreen = not c.fullscreen
    end),
    awful.key({modkey, "Shift"}, ".", function(c)
        c:kill()
    end),
    awful.key({modkey, "Control", "Shift"}, ".", function(c)
        exec("kill -KILL " .. c.pid)
    end),
    awful.key({modkey, "Control"}, "space",  awful.client.floating.toggle),
    awful.key({modkey, "Control"}, "Return", function(c)
        c:swap(awful.client.getmaster())
    end),
    awful.key({modkey}, "o", awful.client.movetoscreen),
--    awful.key({modkey, "Shift"}, "r", function(c)
--        c:redraw()
--    end),
--    awful.key({modkey}, "t", function(c)
--        c.ontop = not c.ontop
--    end),
--    awful.key({modkey}, "n", function(c)
--        -- The client currently has the input focus, so it cannot be
--        -- minimized, since minimized clients can't have the focus.
--        c.minimized = true
--    end),
    awful.key({modkey}, "m", function (c)
        c:swap(awful.client.getmaster())
    end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({modkey}, "#" .. i + 9, function()
            local screen = mouse.screen
            if tags[screen][i] then
                awful.tag.viewonly(tags[screen][i])
            end
        end),
        awful.key({modkey, "Control"}, "#" .. i + 9, function()
            local screen = mouse.screen
            if tags[screen][i] then
                awful.tag.viewtoggle(tags[screen][i])
            end
        end),
        awful.key({modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus and tags[client.focus.screen][i] then
                awful.client.movetotag(tags[client.focus.screen][i])
            end
        end),
        awful.key({modkey, "Control", "Shift"}, "#" .. i + 9, function()
            if client.focus and tags[client.focus.screen][i] then
                awful.client.toggletag(tags[client.focus.screen][i])
            end
        end)
    )
end

clientbuttons = awful.util.table.join(
    awful.button({}, 1, function(c)
        client.focus = c;
        c:raise()
    end),
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize)
)

root.keys(globalkeys)
