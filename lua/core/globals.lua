local sysname = vim.uv.os_uname().sysname
local OS = sysname:match "Windows" and "Windows" or sysname:match "Linux" and "Linux" or sysname -- Windows, Linux, Darwin, NetBSD,...
local is_windows = OS == "Windows"

local global = {
  mapleader = " ",
  maplocalleader = " ",
  toggle_cmp = true, -- enable nvim-cmp
  OS = os,
  is_windows = is_windows,
  path_delimiter = is_windows and ";" or ":",
  path_separator = is_windows and "\\" or "/",
}

for name, value in pairs(global) do
  vim.g[name] = value
end
