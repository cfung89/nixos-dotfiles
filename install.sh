#!/usr/bin/env bash

mkdir -p ~/Github/nvim_plugins
cd ~/Github/nvim_plugins
git clone git@github.com:cfung/embrace.nvim
git clone git@github.com:cfung/surf.nvim

cd ~/Github
git clone git@github.com:cfung/go_tmux_sessionizer
cd go_tmux_sessionizer
nix-shell
go build .
cp ./go_tmux_sessionizer ~/.local/bin/tms

cd ~/nixos-dotfiles/config/tmux/
mkdir plugins
git clone https://github.com/rose-pine/tmux.git plugins/rose-pine-tmux
