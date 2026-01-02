local bb = require("core.bugbrain")

local function try_get_bb_compile_commands()
  local cc = bb.get_current_compile_commands(bb.get_root())

  if cc == nil then
    return ""
  else
    return cc
  end
end

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
      lualine_b = {"branch", "diff"},
      lualine_c = { "diagnostics", { try_get_bb_compile_commands } },
      lualine_x = { "encoding", "filetype"},
      lualine_y = {"progress"},
      lualine_z = {"location"}
    },
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          path = 1,
          newfile_status = true,
        },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "filename",
          path = 1,
          newfile_status = true,
        },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = {}
    },
  },
}
