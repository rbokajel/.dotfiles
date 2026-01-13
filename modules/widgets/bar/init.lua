local awful = require("awful")
local wibox = require("wibox")

local gears = require("gears")

local beautiful = require("beautiful")

local widget_module = "modules.widgets"
require(widget_module .. "core.menu")

local launchers = require(widget_module .. "componenets.launcher")

screen.connect_signal("request::desktop_decoration", function(s) 
    local bar_content = wibox.widget({
        {
            {
                {
                    launchers.fetch_launcher(),  
                    top = 7,
                    widget = wibox.container.margin
                },
                nil,
                {
                    {
                        { },

                        { },
                    }
                    layout = wibox.layout.align.vertical
                },
                {
                    
                },
            },
            bg = beautiful.bg_normal,
            fg = beautiful.fg_normal,
            widget = wibox.container.background
        }
    })
    --[[s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end)
        )
    )

    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }


    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    s.mywibox = awful.wibar({ position = "top", screen = s })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { 
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
            clientbuttons = awful.util.table.join(
                awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
                awful.button({ main_mod }, 1, awful.mouse.client.move),
                awful.button({ main_mod }, 3, awful.mouse.client.resize)
            )
        },
        s.mytasklist, 
        { 
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }]]
end)

