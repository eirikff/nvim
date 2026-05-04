return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {
      enabled = true,
      size = 1.0 * 1024 * 1024, -- 1.0MB
    },
    indent = { enabled = true },
    input = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    picker = {},
    notifier = {
      level = vim.log.levels.INFO,
    },
  },
}
