local programs = {}

programs.terminal = "alacritty"
programs.browser  = "qutebrowser"
programs.editor   = os.getenv("EDITOR") or "nvim"

return programs
