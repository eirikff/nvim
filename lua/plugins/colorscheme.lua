-- return {
--   "navarasu/onedark.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     vim.cmd.colorscheme("onedark")
--   end,
-- }

-- return {
--   "rose-pine/neovim",
--   lazy = false,
--   priority = 1000,
--   name = "rose-pine",
--   config = function()
--     vim.cmd.colorscheme("rose-pine-moon")
--   end
-- }

return {
  "sainnhe/everforest",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.everforest_enable_italic = true
    vim.g.everforest_background = "soft"
    vim.g.everforest_dim_inactive_windows = true
    vim.g.everforest_ui_contrast = "high"
    vim.cmd.colorscheme("everforest")
  end
}
