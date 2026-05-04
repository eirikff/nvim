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

vim.keymap.set("i", "jk", "<Esc>")


--------------------------------------------------------------------------------
-- OPTIONS
--------------------------------------------------------------------------------
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor25" -- cursor to always be block
vim.opt.cursorline = true -- highlight current line
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- Enable mouse mode
vim.opt.breakindent = true
vim.opt.wrap = false
vim.opt.undofile = true -- Save undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.swapfile = false -- Disable swapfiles
vim.opt.backup = false
vim.opt.hlsearch = false -- enable highlight on search
vim.opt.incsearch = true -- enable incremental search
vim.opt.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.opt.smartcase = true
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300
vim.opt.completeopt = "menuone,noselect" -- to have a better completion experience
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
vim.opt.smarttab = true     -- (default on) <Tab> at line start uses shiftwidth

vim.cmd("let g:netrw_liststyle = 0") -- 0 = normal, 3 = tree
vim.cmd("let g:netrw_bufsettings = 'noma nomod nonu nobl nowrap ro rnu'") -- relative numbering


--------------------------------------------------------------------------------
-- PLUGINS
--------------------------------------------------------------------------------
local gh = function(repo) return 'https://github.com/' .. repo end
local pd = function(repo) return "git@gitlab.inne.proxdynamics.com:" .. repo .. ".git" end

vim.pack.add({
  -- Colorschemes
  { src = gh("sainnhe/everforest") },

  -- UI / QoL
  { src = gh("folke/snacks.nvim") },
  { src = gh("nvim-mini/mini.nvim") },
  { src = gh("nvim-lualine/lualine.nvim") },
  { src = gh("tpope/vim-sleuth") },
  { src = gh("hiphish/rainbow-delimiters.nvim") },

  -- Git
  { src = gh("lewis6991/gitsigns.nvim") },

  -- LSP & Mason
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("mason-org/mason.nvim") },

  -- Completion
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/hrsh7th/cmp-path" },


  -- Telescope
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("nvim-telescope/telescope.nvim"), version = "v0.2.0" },

  -- Treesitter
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },

  -- Files / data
  { src = gh("hat0uma/csvview.nvim") },

  -- Custom
  { src = pd("efalck/bugbrain.nvim") },
})


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
})


local function try_get_bb_compile_commands()
  local bb = require("bugbrain.util")
  local cc = bb.get_current_compile_commands(bb.get_root())

  if cc == nil then
    return ""
  else
    return cc
  end
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

require("telescope").setup({
  pickers = {
    lsp_document_symbols = {
      symbol_width = 0.9,
      symbol_type_width = 0.1,
    },
    lsp_references = {
      fname_width = 0.5,
      layout_strategy = "vertical",
      layout_config = {
        width = 0.9,
      }
    }
  }
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Find recently opened files" })
vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "Find existing buffers" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search Select Telescope" })
vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search Git Files" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "Search by Grep on Git Root" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search Resume" })
vim.keymap.set("n", "<leader>sc", [["cyiw<cmd>Telescope live_grep<cr><c-r>c]], { desc = "Live grep word under cursor" })
vim.keymap.set("v", "<leader>sc", [["cy<cmd>Telescope live_grep<cr><c-r>c]], { desc = "Live grep visual selection" })


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


--------------------------------------------------------------------------------
--- LSP
--------------------------------------------------------------------------------
require("mason").setup()

vim.lsp.config("clangd", {
  cmd = { "clangd",
    "--log=verbose",
    "--pretty",
    "--clang-tidy",
    "--completion-style=detailed",
    "--background-index",
    "--enable-config",
    "--query-driver=" .. vim.env.HOME .. "/.conan2/p/gcc-*/p/bin/arm-none-eabi-*",
  }
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local builtin = require("telescope.builtin")
    local opts = { buffer = ev.buf, silent = true }

    opts.desc = "Rename symbol with LSP"
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "Code action"
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    opts.desc = "Goto declaration"
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Goto definition"
    vim.keymap.set("n", "gd", builtin.lsp_definitions, opts)

    opts.desc = "Goto references"
    vim.keymap.set("n", "gr", builtin.lsp_references, opts)

    opts.desc = "Goto implementations"
    vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)

    opts.desc = "Type definitions"
    vim.keymap.set("n", "<leader>D", builtin.lsp_type_definitions, opts)

    opts.desc = "Document symbols"
    vim.keymap.set("n", "<leader>sd", builtin.lsp_document_symbols, opts)

    opts.desc = "Workspace symbols"
    vim.keymap.set("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, opts)

    opts.desc = "Hover documentation"
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  end,
})

vim.lsp.enable("clangd")
vim.lsp.enable("pyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("marksman")
vim.lsp.enable("gopls")
vim.lsp.enable("cmake")
vim.lsp.enable("ts_ls")


--------------------------------------------------------------------------------
--- TREESITTER
--------------------------------------------------------------------------------
local ts = require("nvim-treesitter")
ts.install({
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
    -- Start Tree-sitter parsing and highlighting for the current buffer.
    -- We use 'pcall' so it fails silently if you open a filetype without a parser.
    pcall(vim.treesitter.start, event.buf)

    -- Optional: Enable structural folding based on Tree-sitter logic
    vim.opt.foldlevel = 99
    vim.opt.foldlevelstart = 99
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})


--------------------------------------------------------------------------------
--- AUTOCOMMANDS
--------------------------------------------------------------------------------
-- highlight yanked texted
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 200, })
  end,
})

-- Strip trailing whitespace on save.
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    local buf = args.buf
    if vim.bo[buf].buftype ~= "" then return end

    local view = vim.fn.winsaveview()
    local gs = require("gitsigns")
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
end, { desc = "Copy relative path of current bufer. Append ! to include line number", bang = true })


vim.api.nvim_create_user_command("CopyAbsPath", function(args)
  local path = vim.fn.expand("%:p")
  if args.bang == true then
    local linenumber = vim.api.nvim_win_get_cursor(0)
    path = path .. ":" .. linenumber[1]
  end
  vim.fn.setreg("+", path)
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, { desc = "Copy absolute path of current bufer. Append ! to include line number", bang = true })


--------------------------------------------------------------------------------
--- KEYMAPS
--------------------------------------------------------------------------------

-- open netrw file browser
vim.keymap.set("n", "<leader>pv", "<cmd>Ex<CR>", { desc = "Open netrw file browser" })
vim.keymap.set("n", "<leader>pV", "<cmd>Lex<CR>", { desc = "Toggle netrw file browser in split" })

-- move a chunk of text with capital J or K when highlighted
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- keep cursor in place when using capital J
vim.keymap.set("n", "J", "mzJg`z<cmd>delmark z<cr>")

-- keep cursor in middle of screen when half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")  -- jump down
vim.keymap.set("n", "<C-u>", "<C-u>zz")  -- jump up

-- keep search terms in the middle of the screen when jumping
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- let us keep copied text when pasting over highlighted text
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Keep yanked texted when pasting over highlighted text" })

-- let us copy text directly to the system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy text to system clipboard" })

-- disable the annoying thing that comes up when you press Q accidentally
vim.keymap.set("n", "Q", "<nop>")

-- search and replace the word the cursor is on
vim.keymap.set("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Search and replace word under the cursor" })

-- map esc to exit terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "jk", "<C-\\><C-n>")

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
  { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
  { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Toggle search highlights
vim.keymap.set("n", "<leader>ts", ":set hlsearch!<CR>", { desc = "Toggle search highlights" })
vim.keymap.set("n", "<F9>", ":set hlsearch!<CR>")  -- alternative keymap

vim.keymap.set("n", "<leader>tw", ":set wrap!<CR>", { desc = "Toggle wrap" })

vim.keymap.set("n", "<leader>td", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostic messages" })

vim.keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Open Git" })

vim.keymap.set("i", ";;", "<c-o>A;", { desc = "Append semi-colon to end of line in insert mode" })

vim.keymap.set("n", "<leader><c-g>", "<cmd>CopyRelPath<cr>", { desc = "Copy relative path of current buffer to system clipboard" })
vim.keymap.set("n", "<leader>n<c-g>", "<cmd>CopyRelPath!<cr>", { desc = "Copy relative path with line number of current buffer to system clipboard" })

