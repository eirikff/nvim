This folder is recognized automatically by Neovim's LSP. For each language
server, put specific configuration in a separate Lua file with the filename
equal to the language server name.

E.g. `lua_ls.lua`:

```lua
return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".luarc.jsonc" }
}
```

