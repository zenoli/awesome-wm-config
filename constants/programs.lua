local utils = require "utils"
local programs = {}

local term_fontsize = 12
if utils.is_zenbook() then term_fontsize = 6 end

programs.terminal = "kitty"
programs.browser = "qutebrowser"
programs.editor = "nvim"

return programs
