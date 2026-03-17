# NixOS Dotfiles

My configuration for NixOS, on Wayland.

This repository includes configuration for:
- Sway (NixOS version of my i3 config)
- Waybar
- Rofi
- Ghostty
- tmux
- Neovim

And several other applications...

This repository also includes the NixOS configuration for WSL (*aarch64_linux*).

## Installation

Install and run installation script:
```bash
wget https://raw.githubusercontent.com/cfung89/nixos-dotfiles/main/install.sh
sudo ./install.sh
```
The installation script sets up Github SSH key, `nixos-dotfiles` directory, tmux plugins, personal Neovim plugins, and rebuilds the system.

## Other notes

- Flameshot works with this setup with Sway and wlroots.
- The `add` script runs `git add -N` on every file/directory in `.git_add_ignore` in order to make them visible to the flake without staging them for the commit.
- Binaries for other applications (`tms`) are installed manually in `~/.local/bin`, which is added to `PATH`.
