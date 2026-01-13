local awesome_module = "modules.awesome.core"

local modules = {
    "errors",
    "layouts",
    "rules",
    "signals",
    "tags",
    "theme",
    "user-variables",
    "xrandr",
}

for _, module in ipairs(modules) do
    require(awesome_module .. "." .. module)
end

