return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Document" },
        { "<leader>f", group = "Format" },
        { "<leader>g", group = "Git" },
        { "<leader>h", group = "Git hunk", mode = { "n", "v" } },
        { "<leader>p", group = "Project" },
        { "<leader>s", group = "Search" },
        { "<leader>t", group = "Toggle" },
        { "<leader>w", group = "Workspace" },
      },
    },
  }
}
