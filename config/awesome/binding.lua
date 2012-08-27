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
    end),
    awful.key({modkey}, "a", function()
        shifty.add({rel_index = 1})
    end),
    awful.key({modkey, "Control"}, "a", function()
        shifty.add({rel_index = 1, nopopup = true})
    end),
    awful.key({modkey, "Shift"}, "h", shifty.rename),
    awful.key({modkey}, "w", shifty.del)
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

clientbuttons = awful.util.table.join(
    awful.button({}, 1, function(c)
        client.focus = c;
        c:raise()
    end),
    awful.button({modkey}, 1, awful.mouse.client.move),
    awful.button({modkey}, 3, awful.mouse.client.resize)
)

for i = 1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({modkey}, "#" .. i + 9, function()
            local t = awful.tag.viewonly(shifty.getpos(i))
        end),
        awful.key({modkey, "Control"}, "#" .. i + 9, function()
            local t = shifty.getpos(i)
            t.selected = not t.selected
        end),
        awful.key({modkey, "Control", "Shift"}, "#" .. i + 9, function()
            if client.focus then
                awful.client.toggletag(shifty.getpos(i))
            end
        end),
        awful.key({modkey, "Shift"}, "#" .. i + 9, function()
            if client.focus then
                t = shifty.getpos(i)
                awful.client.movetotag(t)
                awful.tag.viewonly(t)
            end
        end)
    )
end

root.keys(globalkeys)
shifty.config.globalkeys = globalkeys
shifty.config.clientkeys = clientkeys
