local programs = {}

local device_name = os.getenv("DEVICE_NAME")
local term_fontsize = 6
if device_name == "dell-xps-15" then term_fontsize = 12 end

programs.terminal = "alacritty --option " .. term_fontsize
programs.browser  = "qutebrowser"
programs.editor   = os.getenv("EDITOR") or "nvim"

return programs
