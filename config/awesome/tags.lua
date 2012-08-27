shifty.config.tags = {
    ["web"] = {
        position = 1,
        init = true,
        nopopup = true,
        spawn = "x-www-browser",
        spawn = "x-terminal-emulator"
    },
    ["mail"] = {
        position = 2,
        init = true,
        nopopup = true,
        spawn = "icedove",
        layout = "magnifier"
    },
    ["irc"] = {
        position = 3,
        init = true,
        nopopup = true,
        spawn = "x-terminal-emulator -title irc -e bash -i -c irc"
    }
}

shifty.config.apps = {
    {
        {
            match  = {"irc"},
            tag    = "irc"
        },
        {
            match  = {"iceweasel"},
            tag    = "web"
        },
        {
            match  = {"icedove"},
            tag    = "mail"
        },
    },
}

shifty.config.defaults = {
    layout = "max"
}
