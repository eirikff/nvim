local bufnr = vim.api.nvim_get_current_buf()

local opts = {
  buffer = bufnr,
  remap = true,
}

opts.desc = "Close netrw pane"
vim.keymap.set("n", "q", "<cmd>close<CR>", opts)

