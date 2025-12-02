local options = {
  guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor25", -- cursor to always be block
  cursorline = true, -- highlight current line
  number = true, -- Make line numbers default
  relativenumber = true,
  mouse = "a", -- Enable mouse mode
  --clipboard = "unnamedplus", -- sync clipboard with OS
  breakindent = true,
  wrap = true,
  undofile = true, -- Save undo history
  undodir = os.getenv("HOME") .. "/.vim/undodir",
  swapfile = false, -- Disable swapfiles
  backup = false,
  hlsearch = false, -- enable highlight on search
  incsearch = true, -- enable incremental search
  ignorecase = true, -- Case-insensitive searching UNLESS \C or capital in search
  smartcase = true,
  signcolumn = "yes", -- Keep signcolumn on by default
  updatetime = 250, -- Decrease update time
  timeoutlen = 300,
  completeopt = "menuone,noselect", -- to have a better completion experience
  termguicolors = true, -- NOTE: You should make sure your terminal supports this
  colorcolumn = "80,100", -- Add columns 
  scrolloff = 2, -- Add space at top/bottom when scrolling
  formatoptions = "jcrql", -- See :h fo-table for details on each letter
  list = true,
  listchars = {
    tab = "› ",
    trail = "•",
    nbsp = "␣",
    extends = "…",
    precedes = "…",
  }
}

for name, value in pairs(options) do
  vim.opt[name] = value
end

