local awful = require("awful")
local gears = require("gears")

local bindings_module = "modules.bindings.core"
require(bindings_module .. ".keybindings")

local tag_binds = { 7, 8, 9, 0, 5, 1, 2, 3, 4}

for i, v in ipairs(tag_binds) do
    globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ main_mod }, "#" .. i + 9,
    function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[v]
        if tag then
            tag:view_only()
        end
    end,
    {description = "view tag #"..i, group = "tag"}),
    -- Toggle tag display.
    awful.key({ main_mod, "Control" }, "#" .. i + 9,
    function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[v]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end,
    {description = "toggle tag #" .. i, group = "tag"}),
    -- Move client to tag.
    awful.key({ main_mod, "Shift" }, "#" .. i + 9,
    function ()
        if client.focus then
            local tag = client.focus.screen.tags[v]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end

        local screen = awful.screen.focused()
        local tag = screen.tags[v]
        if tag then
            tag:view_only()
        end
    end,
    {description = "move focused client to tag #"..i, group = "tag"}),
    -- Toggle tag on focused client.
    awful.key({ main_mod, "Control", "Shift" }, "#" .. i + 9,
    function ()
        if client.focus then
            local tag = client.focus.screen.tags[v]
            if tag then
                client.focus:toggle_tag(tag)
            end
        end
    end,
    {description = "toggle focused client on tag #" .. i, group = "tag"})
)
end

root.keys(globalkeys)
