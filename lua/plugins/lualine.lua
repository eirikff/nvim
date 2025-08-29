return {
  -- Set lualine as statusline
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = "|",
      section_separators = "",
    },
    sections = {
      lualine_a = {"mode"},
      lualine_b = {"branch", "diff", "diagnostics"},
      lualine_c = {
        {
          "filename",
          path = 1,
          newfile_status = true,
        },
      },
      lualine_x = {"encoding", "filetype"},
      lualine_y = {"progress"},
      lualine_z = {"location"}
    },
  },
}
