require("awful")
require("awful.autofocus")
require("awful.rules")
require("naughty")
require("vicious")
require("shifty")

modkey = "Mod4"

local home = os.getenv("HOME")
local config = home .. "/.config/awesome/"

-- Themes define colours, icons, and wallpapers
beautiful.init(config .. "themes/cool-blue.lua")

dofile(config .. 'layouts.lua')
dofile(config .. 'tags.lua')
dofile(config .. 'wibox.lua')
dofile(config .. 'binding.lua')
dofile(config .. 'rules.lua')
dofile(config .. 'signals.lua')
dofile(config .. 'startup.lua')
