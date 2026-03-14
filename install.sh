#!/usr/bin/env bash

set -euo pipefail

# Set up SSH key with Github
echo "Enter your GitHub email address:"
read -r email
if [ ! -f ~/.ssh/id_github ]; then
    ssh-keygen -t ed25519 -C "$email" -f ~/.ssh/id_github
fi

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_github

echo "-------------------------------------------------------"
cat ~/.ssh/id_github.pub
echo "-------------------------------------------------------"
echo "Add the key to Github: https://github.com/settings/keys"
echo "-------------------------------------------------------"

until [[ "$yn" == "y" || "$yn" == "Y" ]]; do
    read -p "Type 'y' when you've added the key to GitHub: " yn
done

nix-shell -p git go --run "
set -euo pipefail

# Clone dotfiles
cd \$HOME
if [ ! -d \"nixos-dotfiles\" ]; then
    git clone git@github.com:cfung89/nixos-dotfiles.git
fi

# Install personal Neovim plugins
mkdir -p \$HOME/Github/nvim_plugins
cd \$HOME/Github/nvim_plugins
git clone git@github.com:cfung89/embrace.nvim.git || true
git clone git@github.com:cfung89/surf.nvim.git || true
git clone git@github.com:cfung89/cmd-macro.nvim.git || true

# Install go_tmux_sessionizer
cd \$HOME/Github
git clone git@github.com:cfung89/go_tmux_sessionizer.git || true
cd go_tmux_sessionizer
go build -o tms .
mkdir -p \$HOME/.local/bin
mv ./tms \$HOME/.local/bin/tms

# Install tmux plugins
mkdir -p \$HOME/nixos-dotfiles/config/tmux/plugins
cd \$HOME/nixos-dotfiles/config/tmux/plugins
git clone https://github.com/rose-pine/tmux.git rose-pine-tmux || true
"

# Rebuild
target_host="$HOSTNAME"
if [ -n "$target_host" ]; then
    cd ~/nixos-dotfiles/
    ./add
    nixos-rebuild switch --flake ~/nixos-dotfiles#${target_host}
fi
