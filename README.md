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

Install the configuration from this repository by cloning it to `~/.config/nvim/`.

