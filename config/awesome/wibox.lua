clock = awful.widget.textclock({}, "%d/%m/%y %H:%M:%S", 1)
systray = widget({type = "systray"})

-- Create a wibox for each screen and add it
wibox = {}
layoutbox = {}
taglist = {}

mytasklist = {}
for s = 1, screen.count() do
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
