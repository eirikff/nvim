local builtin = require('telescope.builtin')

-- find all files in project
vim.keymap.set('n', '<leader>fp', builtin.find_files, {})

-- find only files tracked by git
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})

-- search for grep regex with live results (REQUIRES: ripgrep)
vim.keymap.set('n', '<leader>fl', builtin.live_grep, {})

