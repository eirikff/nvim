local command = vim.api.nvim_create_user_command

command("TestCmd", function(args)
  vim.notify("This is a test command")
end, { desc = "Test command" })
