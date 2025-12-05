require("markview").setup({
  preview = { enable = false }
})

vim.keymap.set("n", "<leader>tm", "<cmd>Markview toggle<cr>", { desc = "Toggle Markview" })
