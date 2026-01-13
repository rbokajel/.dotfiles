local function set_wallpaper(s)
    local wallpaper = "/home/rbo/downloads/nord_lake.png"

    gears.wallpaper.maximized(wallpaper, s, true)
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
end)
