return {
  {
    "mason-org/mason.nvim",
    dependencies = {
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup({})
      mason_lspconfig.setup({
        ensure_installed = {
          "pyright",
          "clangd",
	  "marksman",
          "lua_ls",
          "bashls"
        },
	-- auto install configured servers (with lspconfig)
	automatic_installation = true,
      })
    end,
  },
}
