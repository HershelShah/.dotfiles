-- Options (must load before lazy.nvim so leader is set when plugins load)
require("config.options")

-- Bootstrap plugin manager, set leader, load plugins
require("config.lazy")

-- Autocommands and keymaps (loaded after plugins so mini.* is available)
require("config.autocmds")
require("config.keymaps")
