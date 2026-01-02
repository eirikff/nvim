return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/lazydev.nvim",
    "hrsh7th/cmp-nvim-lsp", -- lsp source for cmp
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local telescope_builtin = require("telescope.builtin")

    local augroup = vim.api.nvim_create_augroup("UserLspConfig", {})
    vim.api.nvim_create_autocmd("LspAttach", {
      group = augroup,
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        local keymap = vim.keymap.set

        print("Ran LspAttach")

        opts.desc = "Rename symbol with LSP"
        keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

        opts.desc = "Code action"
        keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Goto declaration"
        keymap("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Goto definition"
        keymap("n", "gd", telescope_builtin.lsp_definitions, opts)

        opts.desc = "Goto references"
        keymap("n", "gr", telescope_builtin.lsp_references, opts)

        opts.desc = "Goto implementations"
        keymap("n", "gi", telescope_builtin.lsp_implementations, opts)

        opts.desc = "Type definitions"
        keymap("n", "<leader>D", telescope_builtin.lsp_type_definitions, opts)

        opts.desc = "Document symbols"
        keymap("n", "<leader>sd", telescope_builtin.lsp_document_symbols, opts)

        opts.desc = "Workspace symbols"
        keymap("n", "<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, opts)

        opts.desc = "Hover documentation"
        keymap("n", "K", vim.lsp.buf.hover, opts)
      end,
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    vim.lsp.config("*", {
      capabilities = capabilities
    })

    local mason = require("mason")

    local home = vim.env.HOME
    vim.lsp.config("clangd", {
      cmd = { "clangd",
        "--log=verbose",
        "--pretty",
        "--clang-tidy",
        "--completion-style=detailed",
        "--background-index",
        "--enable-config",
        "--query-driver=" .. home .. "/.conan2/p/gcc-*/p/bin/arm-none-eabi-*",
      }
    })
  end,
}
