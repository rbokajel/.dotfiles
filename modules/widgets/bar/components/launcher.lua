-- Majority of this code is from https://github.com/AlphaTechnolog/dotfiles

local wibox = require("wibox")
local awful = require("awful")

local beautiful = require("beautiful")

local naughty = require("naughty")

local lauchers = { }

local function launcher(opts)
    local launcher = wibox.widget {
        markup = opts.markup,
        align = "center",
        font = beautiful.nerd_font .. " 17",
        widget = wibox.widget.textbox
    }

    launcher:add_button(awful.button( {}, 1, function()
        if opts.onclick then
            opts.onclick()
        end
    end))
end

local rofi = launcher({
    markup = ''
    onclick = function()
        awful.spawn("rofi")
    end
})

launchers.list = {
    rofi
}

launchers.fetch_launchers = function()
    local widget_template = {
        layout = wibox.layout.fixed.vertical,
        spacing = 5
    }

    for _, launcher in ipairs(launchers.list) do
        table.insert(widget_template, launcher)
    end

    return wibox.widget(widget_template)
end

return launchers
