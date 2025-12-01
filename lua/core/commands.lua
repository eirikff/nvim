local command = vim.api.nvim_create_user_command
local bb = require("core.bugbrain")

command("TestCmd", function(args)
  vim.notify("This is a test command")
end, { desc = "Test command" })


-- Gets a list of available targets and sets root compile_commands.json symlink
-- to that target's compile_commands.json.
-- Made specifically for bugbrain and assumes bugbrain is in the bb root path
command("BBSwitchCompileCommands", function()
  local root = bb.get_root()
  if root == nil then
    vim.notify(string.format("Couldn't find bugbrain root (cwd: %s)",
               vim.api.nvim_buf_get_name(0)), vim.log.levels.WARN)
    return
  end

  local build = root .. "/_build"
  local targets = vim.tbl_filter(function(target)
    local cc = build .. "/" .. target .. "/compile_commands.json"
    return vim.fn.filereadable(cc) == 1
  end, vim.fn.readdir(build))

  local current_target = bb.get_current_compile_commands(root)

  vim.ui.select(targets, {
    prompt = "Select target",
    format_item = function(item)
      local fmt = tostring(item)
      if item == current_target then
        fmt = fmt .. "  <-- current"
      end
      return fmt
    end,
  }, function(new_target)
    if new_target == nil then
      vim.notify("No target selected", vim.log.levels.WARN)
      return
    end

    local target_cc = build .. "/" .. new_target .. "/compile_commands.json"
    local root_cc = root .. "/compile_commands.json"

    local cmd = string.format("ln --force --symbolic %s %s", target_cc, root_cc)

    vim.fn.system(cmd)
    local exit_code = vim.v.shell_error
    if exit_code ~= 0 then
      vim.notify("Failed to update symlink", vim.log.levels.ERROR)
      return
    end

    -- Clangd LSP restart for changes to take effect
    vim.cmd("LspRestart clangd")

    vim.notify(target_cc, vim.log.levels.DEBUG)
    vim.notify("Switch to target " .. new_target, vim.log.levels.INFO)
  end)
end, { desc = "Switches bugbrain compile commands symlink" })

