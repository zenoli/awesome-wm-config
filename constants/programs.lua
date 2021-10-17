local utils = require("utils")
local programs = {}

local term_fontsize = 12
if utils.is_zenbook() then term_fontsize = 6 end

programs.terminal = "alacritty --option font.size=" .. term_fontsize
programs.browser  = "qutebrowser"
programs.editor   = os.getenv("EDITOR") or "nvim"

return programs
