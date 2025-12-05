-- 0 = normal, 3 = tree
vim.g.netrw_liststyle = 0

-- relative numbering
vim.g.netrw_bufsettings = 'noma nomod nonu nobl nowrap ro rnu'

local bufnr = vim.api.nvim_get_current_buf()
local opts = {
  buffer = bufnr,
  remap = true,
}

opts.desc = "Close netrw pane"
vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
