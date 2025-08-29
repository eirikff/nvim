-- Require minimum 0.11.x
-- We could be smarter about this, but that's more work than is worth for the 
-- minimal value it gives
assert(
  vim.fn.has("nvim-0.11") == 1,
  "This configuration requires Neovim 0.11 or newer. \z
  Please close and install a newer version."
)

require("core.globals")
require("core.env")
require("core.options")
require("core.netrw")
require("core.commands")
require("core.autocommands")
require("core.filetypes")
require("core.utils")
require("core.keymaps")
