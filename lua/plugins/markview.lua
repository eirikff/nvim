return {
    "OXY2DEV/markview.nvim",
    lazy = false,
    config = function(_, opts)
        opts = vim.tbl_extend("force", opts, {
            preview = { enable = false }
        })
        require("markview").setup(opts)

        vim.keymap.set("n", "<leader>tm", "<cmd>Markview toggle<cr>", { desc = "Toggle Markview" })
    end
}
