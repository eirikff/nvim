-- assert(
--   vim.version.cmp(vim.version(), {0, 12, 0}),
--   "This nvim config is made for v0.12 or greater"
-- )

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- load colorscheme before doing anything else
require("plugins.colorscheme")

require("core.options")
require("core.keymaps")
require("core.filetypes")
require("core.commands")
require("core.autocommands")

require("plugins")
