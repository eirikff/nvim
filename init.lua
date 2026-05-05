assert(
  vim.fn.has("nvim-0.12") == 1,
  "This configuration requires Neovim 0.12 or newer."
)

--------------------------------------------------------------------------------
-- GLOBALS
--------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.snacks_animate = false
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0

vim.g.netrw_liststyle = 0
vim.g.netrw_bufsettings = "noma nomod nonu nobl nowrap ro rnu"


--------------------------------------------------------------------------------
-- OPTIONS
--------------------------------------------------------------------------------
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor25" -- block in normal, bar in insert, underline in replace
vim.opt.cursorline = true -- highlight current line
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.breakindent = true
vim.opt.wrap = false
vim.opt.undofile = true -- Save undo history
vim.opt.undodir = vim.env.HOME .. "/.vim/undodir"
vim.opt.swapfile = false -- Disable swapfiles
vim.opt.backup = false
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.smartcase = true
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300
vim.opt.termguicolors = true -- NOTE: You should make sure your terminal supports this
vim.opt.colorcolumn = "80,100" -- Add columns
vim.opt.scrolloff = 2 -- Add space at top/bottom when scrolling
vim.opt.formatoptions = "jcrql" -- See :h fo-table for details on each letter
vim.opt.list = true
vim.opt.listchars = {
  tab = "› ",
  trail = "•",
  nbsp = "␣",
  extends = "…",
  precedes = "…",
}
vim.opt.winborder = "rounded"

vim.opt.expandtab = true    -- use spaces instead of tab characters
vim.opt.tabstop = 4         -- a literal tab renders as 4 columns wide
vim.opt.softtabstop = -1    -- -1 = copy shiftwidth, pressing <Tab> in insert mode inserts 4 spaces worth
vim.opt.shiftwidth = 4      -- >> and << shift by 4 spaces

-- Default to have all folds open at start
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99


--------------------------------------------------------------------------------
-- PLUGINS
--------------------------------------------------------------------------------
local gh = function(repo) return 'https://github.com/' .. repo end

vim.pack.add({
  -- Colorschemes
  { src = gh("sainnhe/everforest") },

  -- UI / QoL
  { src = gh("folke/snacks.nvim") },
  { src = gh("nvim-mini/mini.nvim") },
  { src = gh("nvim-lualine/lualine.nvim") },
  { src = gh("tpope/vim-sleuth") },

  -- Git
  { src = gh("lewis6991/gitsigns.nvim") },

  -- LSP & Mason
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("mason-org/mason.nvim") },
  { src = gh("mason-org/mason-lspconfig.nvim") },

  -- Completion
  { src = gh("hrsh7th/nvim-cmp") },
  { src = gh("hrsh7th/cmp-nvim-lsp") },
  { src = gh("hrsh7th/cmp-buffer") },
  { src = gh("hrsh7th/cmp-path") },

  -- Treesitter
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },

  -- Files / data
  { src = gh("hat0uma/csvview.nvim") },
})

local bb_dir = vim.fn.stdpath("data") .. "/site/pack/core/opt/bugbrain.nvim"
local bb_installed = vim.fn.isdirectory(bb_dir) == 1

if bb_installed then
  -- Already on disk: register synchronously, no DNS check needed
  vim.pack.add({ { src = "git@gitlab.inne.proxdynamics.com:efalck/bugbrain.nvim.git" } })
else
  -- Not on disk: only attempt clone if we can reach the internal gitlab
  vim.uv.getaddrinfo("gitlab.inne.proxdynamics.com", nil, {}, function(err, _)
    vim.schedule(function()
      if err then
        vim.notify("Unable to reach internal gitlab; bugbrain.nvim not installed", vim.log.levels.WARN)
      else
        vim.pack.add({ { src = "git@gitlab.inne.proxdynamics.com:efalck/bugbrain.nvim.git" } })
      end
    end)
  end)
end

--------------------------------------------------------------------------------
-- COLORSCHEME
--------------------------------------------------------------------------------
vim.g.everforest_enable_italic = true
vim.g.everforest_background = "soft"
vim.g.everforest_dim_inactive_windows = true
vim.g.everforest_ui_contrast = "high"
vim.cmd.colorscheme("everforest")


--------------------------------------------------------------------------------
-- PLUGIN CONFIG
--------------------------------------------------------------------------------
require("snacks").setup({
  bigfile = {
    enabled = true,
    size = 1.0 * 1024 * 1024, -- 1.0MB
  },
  indent = { enabled = true },
  input = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  picker = {},
  notifier = {
    level = vim.log.levels.INFO,
  },
  toggle = {},
})

require('mini.sessions').setup({
  autoread = true,
  verbose = {
    read = true,
    write = true,
    delete = true
  },
})

require('mini.splitjoin').setup()
require('mini.pairs').setup()

local function try_get_bb_compile_commands()
  local ok, bb = pcall(require, "bugbrain.util")
  if not ok then
    return ""
  end

  return bb.get_current_compile_commands(bb.get_root()) or ""
end

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = "|",
    section_separators = "",
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff"},
    lualine_c = { "diagnostics", { try_get_bb_compile_commands } },
    lualine_x = { "encoding", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  },
  winbar = {
    lualine_a = {
      {
        "filename",
        path = 1,
        newfile_status = true,
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  inactive_winbar = {
    lualine_a = {
      {
        "filename",
        path = 1,
        newfile_status = true,
      },
    },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
})

local pick = Snacks.picker
vim.keymap.set("n", "<leader>?",       pick.recent,      { desc = "Pick recent files" })
vim.keymap.set("n", "<leader><space>", pick.buffers,     { desc = "Pick open buffers" })
vim.keymap.set("n", "<leader>sf",      pick.files,       { desc = "Pick files from workspace" })
vim.keymap.set("n", "<leader>sg",      pick.grep,        { desc = "Grep in workspace" })
vim.keymap.set("n", "<leader>sw",      pick.grep_word,   { desc = "Grep word under cursor" })
vim.keymap.set("n", "<leader>sd",      pick.diagnostics, { desc = "Pick diagnostics" })
vim.keymap.set("n", "<leader>sr",      pick.resume,      { desc = "Resume last search" })
vim.keymap.set("n", "<leader>gf",      pick.git_files,   { desc = "Pick git tracked files in workspace" })


require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 300, -- ms
  },
  current_line_blame_formatter = "    <author>, <author_time:%R> - <summary> ",
  current_line_blame_formatter_nc = "    <author> ",
  signs = {
    add          = { text = "+" },
    change       = { text = "~" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  signs_staged = {
    add          = { text = "+" },
    change       = { text = "~" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  on_attach = function(bufnr)
    local gs = require("gitsigns")

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then
        vim.cmd("normal! ]c")
      else
        gs.nav_hunk('next')
      end
    end, { desc = "Jump to next hunk" })

    map('n', '[h', function()
      if vim.wo.diff then
        vim.cmd("normal! [c")
      else
        gs.nav_hunk('prev')
      end
    end, { desc = "Jump to previous hunk" })

    -- visual mode
    map("v", "<leader>hs", function()
      gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { desc = "stage git hunk" })
    map("v", "<leader>hr", function()
      gs.reset_hunk { vim.fn.line ".", vim.fn.line "v" }
    end, { desc = "reset git hunk" })
    -- normal mode
    map("n", "<leader>hs", gs.stage_hunk, { desc = "git stage hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "git reset hunk" })
    map("n", "<leader>hb", function()
      gs.blame_line { full = false }
    end, { desc = "git blame line" })
    map("n", "<leader>hd", gs.diffthis, { desc = "git diff against index" })

    -- Toggles
    map("n", "<leader>tgb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
  end,
})

require('csvview').setup()


--------------------------------------------------------------------------------
--- COMPLETION
--------------------------------------------------------------------------------
local cmp = require("cmp")
cmp.setup({
  completion = {
    completeopt = "menu,menuone,preview,noselect"
  },
  window = {
    completion = {
      border = "none",
    },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete({}), -- show completion suggestions
    ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = {
    -- order determines priority
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", { capabilities = capabilities })

--------------------------------------------------------------------------------
--- LSP
--------------------------------------------------------------------------------
vim.lsp.config("clangd", {
  cmd = { "clangd",
    "--clang-tidy",
    "--completion-style=detailed",
    "--background-index",
    "--enable-config",
    "--query-driver=" .. vim.env.HOME .. "/.conan2/p/gcc-*/p/bin/arm-none-eabi-*",
  }
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "clangd",
    "pyright",
    "lua_ls",
    "bashls",
  },
  automatic_enable = true,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local function nmap(keys, func, desc)
      local opts = { buffer = ev.buf, silent = true, desc = desc }
      vim.keymap.set("n", keys, func, opts)
    end

    nmap("K",          vim.lsp.buf.hover,          "Hover documentation")
    nmap("gD",         vim.lsp.buf.declaration,    "Goto declaration")
    nmap("<leader>rn", vim.lsp.buf.rename,         "Rename symbol with LSP")
    nmap("<leader>ca", vim.lsp.buf.code_action,    "Code action")

    nmap("gd",         pick.lsp_definitions,       "Goto definition")
    nmap("gr",         pick.lsp_references,        "Goto references")
    nmap("gi",         pick.lsp_implementations,   "Goto implementations")
    nmap("<leader>D",  pick.lsp_type_definitions,  "Type definitions")
    nmap("<leader>sd", pick.lsp_symbols,           "Document symbols")
    nmap("<leader>ws", pick.lsp_workspace_symbols, "Workspace symbols")
  end,
})


--------------------------------------------------------------------------------
--- TREESITTER
--------------------------------------------------------------------------------
require("nvim-treesitter").install({
  "asm",
  "bash",
  "c",
  "cmake",
  "comment",
  "cpp",
  "css",
  "csv",
  "desktop",
  "devicetree",
  "diff",
  "disassembly",
  "dockerfile",
  "doxygen",
  "gitattributes",
  "gitcommit",
  "git_config",
  "gitignore",
  "git_rebase",
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
  "json5",
  "latex",
  "linkerscript",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
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
  "query",
  "regex",
  "requirements",
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
  "vim",
  "vimdoc",
  "xml",
  "yaml",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function(event)
    -- Skip special buffers
    if vim.bo[event.buf].buftype ~= "" then return end

    local lang = vim.treesitter.language.get_lang(vim.bo[event.buf].filetype)
    if not lang or not vim.treesitter.language.add(lang) then return end

    vim.treesitter.start(event.buf)
    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  end,
})


--------------------------------------------------------------------------------
--- AUTOCOMMANDS
--------------------------------------------------------------------------------
-- highlight yanked texted
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ timeout = 200, })
  end,
})

-- Strip trailing whitespace on save.
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local buf = args.buf
    if vim.bo[buf].buftype ~= "" then return end

    local view = vim.fn.winsaveview()
    local gs = package.loaded.gitsigns
    local hunks = gs and gs.get_hunks(buf)

    if hunks == nil then
      -- Not a git repo, gitsigns hasn't attached, or it errored:
      -- strip the whole buffer.
      vim.cmd([[silent! keeppatterns %s/\s\+$//e]])
    else
      -- gitsigns hunks: { type, added = { start, count, lines }, removed = ... }
      -- We want lines on the "added" side (the buffer's current state).
      for _, hunk in ipairs(hunks) do
        if hunk.type == "add" or hunk.type == "change" then
          local start = hunk.added.start
          local count = hunk.added.count
          for lnum = start, start + count - 1 do
            local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
            if line then
              local stripped = line:gsub("%s+$", "")
              if stripped ~= line then
                vim.api.nvim_buf_set_lines(buf, lnum - 1, lnum, false, { stripped })
              end
            end
          end
        end
      end
    end

    vim.fn.winrestview(view)
  end,
})


--------------------------------------------------------------------------------
--- USER COMMANDS
--------------------------------------------------------------------------------
local show_spaces = false
vim.api.nvim_create_user_command("ToggleSpace", function()
  show_spaces = not show_spaces

  if show_spaces then
    vim.opt.listchars:append({ space = "·" })
  else
    vim.opt.listchars:remove("space")
  end
end, { desc = "Toggles displaying space with a visible indicator" })


vim.api.nvim_create_user_command("CopyRelPath", function(args)
  local path = vim.fn.expand("%")
  if args.bang == true then
    local linenumber = vim.api.nvim_win_get_cursor(0)
    path = path .. ":" .. linenumber[1]
  end
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy relative path of current buffer. Append ! to include line number", bang = true })


vim.api.nvim_create_user_command("CopyAbsPath", function(args)
  local path = vim.fn.expand("%:p")
  if args.bang == true then
    local linenumber = vim.api.nvim_win_get_cursor(0)
    path = path .. ":" .. linenumber[1]
  end
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy absolute path of current buffer. Append ! to include line number", bang = true })


--------------------------------------------------------------------------------
--- KEYMAPS
--------------------------------------------------------------------------------
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Open netrw file browser" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>") -- map esc to exit terminal mode
vim.keymap.set("t", "jk", "<C-\\><C-n>")
vim.keymap.set("n", "J", "mzJg`z<cmd>delmark z<cr>") -- keep cursor in place when using capital J
vim.keymap.set("n", "n", "nzzzv") -- keep search term in middle of screen
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Keep yanked text when pasting over highlighted text" })
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy text to system clipboard" })
-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
Snacks.toggle.diagnostics():map("<leader>td")
Snacks.toggle.option("hlsearch"):map("<leader>ts")
Snacks.toggle.option("wrap"):map("<leader>tw")
vim.keymap.set("n", "<leader><c-g>", "<cmd>CopyRelPath<cr>", { desc = "Copy relative path of current buffer to system clipboard" })
vim.keymap.set("n", "<leader>n<c-g>", "<cmd>CopyRelPath!<cr>", { desc = "Copy relative path with line number of current buffer to system clipboard" })

