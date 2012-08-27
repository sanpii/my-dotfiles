shifty.config.tags = {
    ["web"] = {
        init = true,
        position = 1,
        spawn = "x-www-browser"
    },
    ["mail"] = {
        init = true,
        position = 2,
        spawn = "icedove",
        layout = awful.layout.suit.magnifier
    },
    ["irc"] = {
        init = true,
        position = 3,
        spawn = "x-terminal-emulator -e bash -i -c irc"
    }
}

shifty.config.defaults = {
    layout = awful.layout.suit.max
}
