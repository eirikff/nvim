-- use jk to leave insert mode  
vim.keymap.set("i", "jk", "<Esc>")

vim.g.mapleader = " "

-- open netrw file browser 
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move a chunk of text with capital J or K when highlighted
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in place when using capital J
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in middle of screen when half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")  -- jump down
vim.keymap.set("n", "<C-u>", "<C-u>zz")  -- jump up

-- keep search terms in the middle of teh screen when jumping
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- let us keep copied text when pasting over highlighted text
vim.keymap.set("x", "<leader>p", [["_dP]])

-- let us copy text directly to the system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- disable the annoying thing that comes up when you press Q accidentally
vim.keymap.set("n", "Q", "<nop>")

-- automatically format code 
vim.keymap.set("n", "<leader>ff", vim.lsp.buf.format)

-- search and replace the word the cursor is on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- map esc to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

