-- change cursor style to always be block
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor25"

-- enable line numbes
vim.opt.nu = true
vim.opt.relativenumber = false

-- set tab to 4 spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- https://vi.stackexchange.com/questions/5818/what-is-the-difference-between-autoindent-and-smartindent-in-vimrc
vim.opt.autoindent = true
vim.opt.smartindent = true

-- disable line wrap
vim.opt.wrap = false

-- disable swap files and enable undo files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- highlight search results
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
-- When searching try to be smart about cases. I.e., when a pattern contains
-- an uppercase letter it's included in the search, but when it's only lowercase
-- ignorecase is active
vim.opt.smartcase = true

-- enable more nice colors
vim.opt.termguicolors = true

vim.opt.scrolloff = 1
vim.opt.signcolumn = "auto"

-- colored columns at specified columns
vim.opt.colorcolumn = "80,100"

-- custom status line format
vim.opt.statusline = " %F%m%r%h %w  CWD:%r%{getcwd()}%h   L:%l C:%c"
vim.opt.laststatus = 2  -- always show status line

