local menubar = require("menubar")

-- Default variables
terminal = "alacritty"
editor = os.getenv("EDITOR")
editor_cmd = terminal .. " -e " .. editor
file_manager = "nemo"
browser = "qutebrowser"

main_mod = "Mod4"

menubar.utils.terminal = terminal
