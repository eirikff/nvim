require("plugins.colorscheme")

vim.pack.add({
  "https://github.com/tpope/vim-sleuth",
  "https://github.com/HiPhish/rainbow-delimiters.nvim",

  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/folke/snacks.nvim",
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/folke/which-key.nvim",
  "https://github.com/lewis6991/gitsigns.nvim",


  "https://github.com/OXY2DEV/markview.nvim",
  "https://github.com/hat0uma/csvview.nvim",
})

require("plugins.treesitter")

require("plugins.mini")
require("plugins.snacks")
require("plugins.lualine")
require("plugins.which-key")
require("plugins.gitsigns")
require("plugins.markview")
require("plugins.csvview")

