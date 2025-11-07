-- see examples here:
-- https://github.com/Alexis12119/nvim-config/blob/main/lua/core/autocommands.lua
-- https://www.youtube.com/watch?v=v36vLiFVOXY

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- highlight yanked texted
autocmd("TextYankPost", {
  group = augroup("YankHighlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, })
  end,
})

-- open help in vertical split to the right
autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

