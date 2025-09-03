return {
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "nvim-treesitter/nvim-treesitter-refactor",
    },
    lazy = false, -- doesn't support lazy loading
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- TODO: uncomment after testing auto install
          -- "python",
          -- "cpp",
          -- "bash",
          -- "make",
          -- "asm",
          -- "comment",
          -- "cmake",
          -- "csv",
          -- "dockerfile",
          -- "git_rebase",
          -- "gitcommit",
          -- "gitignore",
          -- "json",
          -- "printf",
          -- "regex",
          -- below should always be installed
          "c",
          "lua",
          "luadoc",
          "vim",
          "vimdoc",
          "query",
          "markdown",
          "markdown_inline",
        },
        ignore_install = {},
        auto_install = true,
        sync_install = false,

        -- module configuration
        highlight = {
          enable = true,
          -- disable normal vim regex highlighting as having both enabled can
          -- slow things down
          additional_vim_regex_highlighting = false,
        },
        
        indent = {
          enable = true,
        },
        
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-Space>",
            node_incremental = "<C-Space>",
            node_decremental = "<M-Space>",
          },
        },

        refactor = {
          highlight_definitions = {
            enable = true,
            clear_on_cursor_mode = true,
          },
          highlight_current_scope = {
            enable = false,
          },
        },
      })

      local ts_ctx = require("treesitter-context")
      ts_ctx.setup({
        enable = true,
        multiline_threshold = 5,
        mode = "cursor", -- makes the cursor decide which scopes to display
      })

      vim.keymap.set({ "n", "v" }, "[c", function() 
        ts_ctx.go_to_context(vim.v.count1)
      end, { desc = "Go up one context level" })

      vim.keymap.set("n", "<leader>tc", ts_ctx.toggle, { desc = "Toggle context" })

      -- configure folding
      vim.opt.foldlevel = 99 -- open all folds by default
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
  },
}
