local awful = require("awful")
local gears = require("gears")

local awesome_module = "modules.awesome.core"

local xrandr = require(awesome_module .. ".xrandr")
require(awesome_module .. ".user-variables")

globalkeys = gears.table.join(
    awful.key(
        { main_mod, "Control" }, "r",
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
        { main_mod }, "r",
        function () awful.screen.focused().mypromptbox:run() end,
        {description = "run prompt", group = "launcher"}
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
