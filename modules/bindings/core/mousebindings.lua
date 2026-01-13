local awful = require("awful")

local widget_module = "modules.widgets.core"
require(widget_module .. ".menu")

-- Global Mouse Binds
root.buttons(
    awful.util.table.join(
        awful.button({ }, 3, function () mainmenu:toggle() end),
        awful.button({ }, 4, awful.tag.viewnext),
        awful.button({ }, 5, awful.tag.viewprev)
    )
)


clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ main_mod }, 1, awful.mouse.client.move),
    awful.button({ main_mod }, 3, awful.mouse.client.resize)
)
