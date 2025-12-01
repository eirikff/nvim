local M = {}

function M.get_root()
  local root_markers = { "_build", "compile_commands.json", ".clangd" }
  local cwd = vim.api.nvim_buf_get_name(0)
  local root = vim.fs.root(cwd, root_markers)

  return root
end

function M.get_current_compile_commands(root)
  if root == nil then
    return nil
  end

  local current_cc = vim.fn.resolve(root .. "/compile_commands.json")
  if vim.fn.filereadable(current_cc) == 1 then
    return vim.fs.basename(vim.fs.dirname(current_cc))
  end
  return nil
end

return M
