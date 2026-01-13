pcall(require, "luarocks.loader")

require("awful.autofocus")

require("awful.hotkeys_popup.keys")

require("modules")

--[[if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Hey man, there was an error when starting ...",
        text = "To help you out: " .. awesome.startup_errors
    })
end

-- Runtime Errors
do
    local in_error = false
    awesome.connect_signal(
        "debug::error", 
        function (err)
            if in_error then return end
            in_error = true

            naughty.notify({
                preset = naughty.config.presets.critical,
                title = "Oof .. this is awkward",
                text = "To help you out: " .. tostring(err)
            })
        end
    )
end

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- Default variables
terminal = "alacritty"
editor = os.getenv("EDITOR")
editor_cmd = terminal .. " -e " .. editor
file_manager = "nemo"
browser = "qutebrowser"

main_mod = "Mod4"

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
}

myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ 
    items = { 
        { "awesome", myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }
})

mylauncher = awful.widget.launcher({ 
    image = beautiful.awesome_icon,
    menu = mymainmenu 
})

local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ main_mod }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ main_mod }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

menubar.utils.terminal = terminal

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
        s.mylayoutbox:buttons(gears.table.join(
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc( 1) end),
            awful.button({ }, 5, function () awful.layout.inc(-1) end)
        )
    )
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ main_mod }, 1, awful.mouse.client.move),
    awful.button({ main_mod }, 3, awful.mouse.client.resize)
)
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)

root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

globalkeys = gears.table.join(
    awful.key(
        { main_mod, "Shift" }, "r",
        awesome.restart,
        {description = "reload awesome wmanager", group = "awesome"}
    ),
    awful.key(
        { main_mod }, "q",
        awesome.quit,
        {description = "quit awesome wmanager", group = "awesome"}
    ),

    awful.key(
        { main_mod }, ";",
        function () awful.spawn(terminal) end,
        {description = "alacritty launcher", group = "launcher"}
    ),
    awful.key(
        { main_mod }, "b",
        function () awful.spawn(browser) end,
        {description = "qutebrowser launcher", group = "launcher"}
    ),
    awful.key(
        { main_mod }, "e",
        function () awful.spawn(file_manager) end,
        {description = "nemo launcher", group = "launcher"}
    ),

    awful.key(
        { main_mod }, "j",
        function ()
            awful.client.focus.byidx(1)
        end,
        {description = "shift focus forward", group = "layout"}
    ),
    awful.key(
        { main_mod }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "shift focus forward", group = "layout"}
    ),

    awful.key(
        { main_mod, "Shift" }, "j",
        function ()
            awful.client.swap.byidx(1)
        end,
        {description = "shift focus forward", group = "layout"}
    ),
    awful.key(
        { main_mod, "Shift" }, "k",
        function ()
            awful.client.swap.byidx(-1)
        end,
        {description = "shift focus forward", group = "layout"}
    ),

    awful.key(
        { main_mod, "Control" }, "j",
        function ()
            awful.screen.focus_relative(1)
        end,
        {description = "switch screen forward", group = "layout"}
    ),
    awful.key(
        { main_mod, "Control" }, "k",
        function ()
            awful.screen.focus_relative(-1)
        end,
        {description = "switch screen backward", group = "layout"}
    ),
    
    awful.key(
        { main_mod }, "l",
        function ()
            awful.tag.incmwfact(0.05)
        end,
        {description = "resize up", group = "layout"}
    ),
    awful.key(
        { main_mod }, "h",
        function ()
            awful.tag.incmwfact(-0.05)
        end,
        {description = "resize down", group = "layout"}
    ),

    awful.key(
        { main_mod, "Shift" }, "l",
        function ()
            awful.tag.incnmaster(1, nil, true)
        end,
        {description = "shift up", group = "layout"}
    ),
    awful.key(
        { main_mod, "Shift" }, "h",
        function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        {description = "shift down", group = "layout"}
    ),

    awful.key(
        { main_mod, "Control" }, "n",
        function ()
            local c = awful.client.restore()

            if c then
                c:emit_signal(
                    "request::activate", "key.unminimize", {raise = true}
                )
            end
        end
    ),

    awful.key(
        { main_mod, "Control" }, "/",
        function () xrandr.xrandr() end
    )
)

root.keys(globalkeys)

clientkeys = gears.table.join(
    awful.key(
        { main_mod }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),

    awful.key(
        { main_mod, "Shift"   }, "c",      
        function (c) c:kill() end,
        {description = "close", group = "client"}
    ),

    awful.key(
        { main_mod, "Control" }, "space",  
        awful.client.floating.toggle,
        {description = "toggle floating", group = "client"}
    ),


    awful.key(
        { main_mod }, "o",
        function (c) c:move_to_screen() end,
        {description = "move to screen", group = "client"}
    ),


    awful.key(
        { main_mod }, "n",
        function (c)
            c.minimized = true
        end, 
        {description = "minimize", group = "client"}
    ),

    awful.key(
        { main_mod }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}
    )
)

local tag_bindings = { 7, 8, 9, 0, 6, 1, 2, 3, 4 }

for i, v in ipairs(tag_bindings) do
    globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ main_mod }, "#" .. v + 9,
    function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            tag:view_only()
        end
    end,
    {description = "view tag #"..i, group = "tag"}),
    -- Toggle tag display.
    awful.key({ main_mod, "Control" }, "#" .. v + 9,
    function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end,
    {description = "toggle tag #" .. i, group = "tag"}),
    -- Move client to tag.
    awful.key({ main_mod, "Shift" }, "#" .. v + 9,
    function ()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end

        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            tag:view_only()
        end
    end,
    {description = "move focused client to tag #"..i, group = "tag"}),
    -- Toggle tag on focused client.
    awful.key({ main_mod, "Control", "Shift" }, "#" .. v + 9,
    function ()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:toggle_tag(tag)
            end
        end
    end,
    {description = "toggle focused client on tag #" .. i, group = "tag"})
)
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ main_mod }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ main_mod }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
awful.rules.rules = {
    -- All clients will match this rule.
    { 
        rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },

    -- Floating clients.
    { 
        rule_any = {
            instance = {
                "DTA",  -- Firefox addon DownThemAll.
                "copyq",  -- Includes session name in class.
                "pinentry",
            },
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin",  -- kalarm.
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer"
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                "Event Tester",  -- xev.
            },
            role = {
                "AlarmWindow",  -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
            }
        }, 

        properties = { floating = true }
    },

    -- Add titlebars to normal clients and dialogs
    { 
        rule_any = {
            type = { "normal", "dialog" } 
        }, 
        properties = { titlebars_enabled = true }
    },
    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}

client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
        and not c.size_hints.user_position
        and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

]]
