-- see examples here:
-- https://github.com/Alexis12119/nvim-config/blob/main/lua/core/autocommands.lua
-- https://www.youtube.com/watch?v=v36vLiFVOXY

-- highlight yanked texted
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, })
  end,
})

-- open help in vertical split to the right
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

