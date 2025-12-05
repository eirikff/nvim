local snacks = require("snacks")
snacks.setup({
  bigfile = { enabled = true },
  indent = { enabled = true },
  input = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  picker = { enabled = true },
  notifier = {
    enabled = true,
    level = vim.log.levels.INFO,
  },
})
