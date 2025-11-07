-- [[ My keymaps ]]

-- use jk to leave insert mode  
vim.keymap.set("i", "jk", "<Esc>")

-- open netrw file browser
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Open netrw file browser" })
vim.keymap.set("n", "<leader>pV", "<cmd>Lex<CR>", { desc = "Toggle netrw file browser in split" })

-- move a chunk of text with capital J or K when highlighted
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in place when using capital J
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in middle of screen when half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")  -- jump down
vim.keymap.set("n", "<C-u>", "<C-u>zz")  -- jump up

-- keep search terms in the middle of the screen when jumping
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- let us keep copied text when pasting over highlighted text
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Keep yanked texted when pasting over highlighted text" })

-- let us copy text directly to the system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy text to system clipboard" })

-- disable the annoying thing that comes up when you press Q accidentally
vim.keymap.set("n", "Q", "<nop>")

-- automatically format code 
-- vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format, { desc = "Format code using LSP" })

-- search and replace the word the cursor is on
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under the cursor" })

-- map esc to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Toggle search highlights 
vim.keymap.set("n", "<leader>ts", ":set hlsearch!<CR>", { desc = "Toggle search highlights" })
vim.keymap.set("n", "<F9>", ":set hlsearch!<CR>")  -- alternative keymap

vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = "Toggle wrap" })

vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostic messages" })

vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Open Git" })
