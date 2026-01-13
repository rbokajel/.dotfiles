local awful = require("awful")
local wibox = require("wibox")

local gears = require("gears")

local beautiful = require("beautiful")

local widget_module = "modules.widgets"
require(widget_module .. ".core.menu")

local launchers = require(widget_module .. ".bar.components.launcher")

screen.connect_signal("request::desktop_decoration", function(s) 
    local bar_content = wibox.widget({
        {
            {
                launchers.fetch_launchers(),
                top = 7,
                widget = wibox.container.margin
            },
            bg = beautiful.bg_normal,
            fg = beautiful.fg_normal,
            widget = wibox.container.background
        }
    })

    local bar = awful.popup {
        visible = true,
        ontop = false,
        minimum_height = s.geometry.height - beautiful.useless_gap * 4,
        minimum_width = beautiful.bar_width,
        bg = beautiful.bg_normal .. "00",
        fg = beautiful.fg_normal,
        widget = bar_content,
        screen = s,
        placement = function (d)
            return awful.placement.left(d, {
                margins = {
                    left = beautiful.useless_gap * 2
                }
            })
        end
    }

    bar:struts {
        left = beautiful.bar_width + beautiful.useless_gap * 2
    }
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

