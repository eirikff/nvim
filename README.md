# Neovim configuration

## Installation

Install [latest stable version from Github](https://github.com/neovim/neovim/releases/tag/stable). 
For Linux, it's easiest to download the AppImage to `/opt/nvim/` and add it to `PATH` like this:

```bash
sudo mkdir -p /opt/nvim/ 
sudo wget 'https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.appimage' -O /opt/nvim/nvim
sudo chmod +x /opt/nvim/nvim

export PATH=/opt/nvim/:$PATH
```

Optionally, install using `snap`:

```bash
sudo snap install nvim --classic
```

Install the configuration from this repository by cloning it to
`~/.config/nvim/`.


## Core

Core modules are configuration for Vim and Neovim that don't require any
plugins. This is for example keymaps, Vim options, autocommands, Lua utility
functions, etc. 


## Plugins

Most plugins get their own file to take adavante of Lazy's caching. Configure
each plugin by returning a Lua table with Lazy's plugin spec.

Many plugins can be configured by defining the `opts` table with settings. For
those that require additional setup by running code, e.g. to configure keymaps,
call or configure other modules, etc., define the `config` key in the Lazy
plugin spec as a function:

```lua
config = function()
  require("module").setup({
    ...
  })
  
  vim.keymap.set(...)
end
```

If the plugin spec also defines the `opts` key, it's given to the `config`
function as the second argument, i.e. `config = function(_, opts) ... end`. In
this case, remember to extend the `opts` table as necessary, then call
`require(...).setup(opts)` since this is not done automatically when the
`config` key is defined.


Below is a short description of the major plugins.

### Telescope

The Telescope plugin provides many different pickers to find files, search in
buffer, LSP symbols, etc. See [README on
Github](https://github.com/nvim-telescope/telescope.nvim/tree/master?tab=readme-ov-file#pickers)
for a list of pickers.

To use a picker, in the keymap function argument, write

```lua
require("telescope.builtin").find_files
```

or 

```
"<cmd>Telescope find_files<CR>"
```

to trigger the picker with this keymap.


### Treesitter

Treesitter parses the buffer and very efficiently creates a syntax tree that 
makes syntax highlighting and navigating the code better.

The `master` branch is now deprecated, and the extensions (`context` and
`refactor`) no longer works with the new `main` branch since the extension 
system no longer exists. This configuration should be updated to use the new
`main` branch at some point. 


### cmp

`nvim-cmp` is the completion engine that gives the dropdown menu with
suggestions. It takes different sources from where to get completion
information from. 


### LSP and Mason

LSP interacts with a third-party language server process to make code
navigation better.

Mason is a package manager for language servers. 


### Lualine

Creates a nicer and more configurable status line. 


### Which key

Provides help for which keymaps exists when a partial keymap is pressed. This 
is extracted from the `desc` field of the options in the keymaps, but specific
groups and full keymaps can be defined in the plugin spec. 


### Git related plugins

Fugitive gives the `:Git` (`:G` for short) command for managing Git. This is 
a nice wrapper around the `git` command line interface.

Gitsigns gives the column besides the line numbers with Git status symbols.


### Snacks

A collection of many small nice-to-haves and quality of life functions. It also
changes some of the standard API to give nicer input dialog boxes. 


