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
      lualine_b = {"branch", "diff", "diagnostics"},
      lualine_c = {
        {
          "filename",
          path = 1,
          newfile_status = true,
        },
      },
      lualine_x = { { try_get_bb_compile_commands }, "encoding", "filetype"},
      lualine_y = {"progress"},
      lualine_z = {"location"}
    },
  },
}
