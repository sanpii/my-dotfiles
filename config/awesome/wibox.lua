clock = awful.widget.textclock({}, "%d/%m/%y %H:%M:%S", 1)
systray = widget({type = "systray"})

separator = widget({ type = "textbox" })
separator.text = ' <span color="black">|</span> '

wibox = {}
layoutbox = {}
taglist = {}
tasklist = {}

for s = 1, screen.count() do
    layoutbox[s] = awful.widget.layoutbox(s)
    taglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all)
    tasklist[s] = awful.widget.tasklist(function(c)
        return awful.widget.tasklist.label.currenttags(c, s)
    end)

    wibox[s] = awful.wibox({position = "top", screen = s})
    wibox[s].widgets = {
        {
            taglist[s], separator, layoutbox[s], separator,
            layout = awful.widget.layout.horizontal.leftright
        },
        s == 1 and systray or nil,
        separator, clock,
        separator, tasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
    }
end

shifty.taglist = taglist
shifty.init()
