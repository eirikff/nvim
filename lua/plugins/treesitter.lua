local ts = require("nvim-treesitter")

-- See list at:
-- https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
local ensure_installed = {
  -- These should always be installed
  "c",
  "lua",
  "luadoc",
  "vim",
  "vimdoc",
  "query",
  "markdown",
  "markdown_inline",

  "asm",
  "bash",
  "cmake",
  "comment",
  "cpp",
  "css",
  "csv",
  "devicetree",
  "diff",
  "disassembly",
  "dockerfile",
  "doxygen",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "haskell",
  "html",
  "htmldjango",
  "ini",
  "javascript",
  "jinja",
  "jinja_inline",
  "jq",
  "json",
  "json",
  "json5",
  "jsonc",
  "jsx",
  "linkerscript",
  "make",
  "matlab",
  "nasm",
  "nginx",
  "objdump",
  "ocaml",
  "passwd",
  "perl",
  "php",
  "powershell",
  "printf",
  "python",
  "regex",
  "requirements",
  "robots",
  "rust",
  "scss",
  "sql",
  "ssh_config",
  "strace",
  "tcl",
  "tmux",
  "todotxt",
  "toml",
  "tsv",
  "tsx",
  "typescript",
  "typst",
  "udev",
  "vhdl",
  "xml",
  "yaml",
  "zsh",
}

ts.install(ensure_installed)
ts.update()

-- TODO: is this necessary?
vim.api.nvim_create_autocmd('FileType', {
  pattern = ensure_installed,
  callback = function()
    vim.treesitter.start()

    vim.opt.foldlevel = 99 -- open options that are disabled in help page
    vim.wo.foldmethod = 'expr'
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- TODO: make autocommand to install missing parsers
--       See :h nvim-treesitter.get_installed and
--       :h nvim-treesitter.get_available
