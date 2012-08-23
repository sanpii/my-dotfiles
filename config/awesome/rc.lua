require("awful")
require("awful.autofocus")
require("awful.rules")
require("naughty")

-- {{{ Variable definitions
local home  = os.getenv("HOME")
local exec = awful.util.spawn
local sexec = awful.util.spawn_with_shell
local scount = screen.count()

-- This is used later as the default terminal and editor to run.
editor = os.getenv("EDITOR") or "editor"
editor_cmd = "x-terminal-emulator -e " .. editor
modkey = "Mod4"

-- Themes define colours, icons, and wallpapers
beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, scount do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Wibox
clock = awful.widget.textclock({}, "%d/%m/%y %H:%M:%S", 1)
systray = widget({type = "systray"})

-- Create a wibox for each screen and add it
wibox = {}
layoutbox = {}
taglist = {}

mytasklist = {}
for s = 1, scount do
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    layoutbox[s] = awful.widget.layoutbox(s)
    -- Create a taglist widget
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
        return awful.widget.tasklist.label.currenttags(c, s)
    end)

    -- Create the wibox
    wibox[s] = awful.wibox({position = "top", screen = s})
    -- Add widgets to the wibox - order matters
    wibox[s].widgets = {
        {
            taglist[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        layoutbox[s],
        s == 1 and systray or nil,
        clock,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end
-- }}}

-- {{{ Key bindings
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
for s = 1, scount do
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
-- }}}

-- {{{ Rules
awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = true,
            keys = clientkeys,
            buttons = clientbuttons
        }
    }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function(c, startup)
    -- Enable sloppy focus
    c:add_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end
end)

client.add_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.add_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)
-- }}}

-- Startup {{{
 sexec("davmail")
 sexec("xirc")
 sexec("icedove")
 sexec("x-www-browser")
 sexec("xautolock")
 sexec("zim --plugin trayicon")
-- }}}
