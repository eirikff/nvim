-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
      'python',
      'cpp',
      'bash',
      'markdown',
      -- The following should always be installed
      'c',
      'lua',
      'vim',
      'vimdoc',
      'query'
    },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
    sync_install = false,
    ignore_install = {},

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
    refactor = {
      highlight_definitions = {
        enable = true,
        clear_on_cursor_move = true,
      },
    }
  })

  TSCtx = require("treesitter-context")
  TSCtx.setup({
    multiline_threshold = 3
  })
  vim.keymap.set("n", "[c", function()
    TSCtx.go_to_context(vim.v.count1)
  end, { silent = true })

  vim.keymap.set("n", "<leader>tc", TSCtx.toggle, { desc = "Toggle context" })
end, 0)

-- vim: ts=2 sts=2 sw=2 et
