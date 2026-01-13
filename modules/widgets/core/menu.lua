local awful = require("awful")
local beautiful = require("beautiful")

local awesome_module = "modules.awesome.core"
require(awesome_module .. ".user-variables")

awesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

mainmenu = awful.menu({ 
    items = { 
        { "awesome", awesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
        { "restart", awesome.restart }
    }
})

launcher = awful.widget.launcher({ 
    image = beautiful.awesome_icon,
    menu = mainmenu 
})

