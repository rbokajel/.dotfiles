local bindings_module = "modules.bindings.core"

local modules = {
    "keybindings",
    "mousebindings",
    "tagbindings"
}

for _, module in ipairs(modules) do
    require(bindings_module .. "." .. module) 
end

