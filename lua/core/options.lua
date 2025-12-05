vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true

vim.opt.scrolloff = 2 -- Add space at top/bottom when scrolling

vim.opt.mouse = "a" -- Enable mouse mode

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor25" -- cursor to always be block
vim.opt.termguicolors = true -- NOTE: You should make sure your terminal supports this
vim.opt.cursorline = true -- highlight current line

vim.opt.clipboard = "unnamedplus" -- sync clipboard with OS
vim.opt.breakindent = true
vim.opt.wrap = false

vim.opt.undofile = true -- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.swapfile = false -- Disable swapfiles
vim.opt.backup = false

vim.opt.hlsearch = false -- enable highlight on search
vim.opt.incsearch = true -- enable incremental search
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.smartcase = true

vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300

vim.opt.completeopt = "menuone,noselect" -- to have a better completion experience
vim.opt.colorcolumn = "80,100" -- Add columns 
vim.opt.formatoptions = "jcrql" -- See :h fo-table for details on each letter

vim.opt.list = true
vim.opt.listchars = {
  tab = "› ",
  trail = "•",
  nbsp = "␣",
  extends = "…",
  precedes = "…",
}
