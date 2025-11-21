{ config, pkgs, ... }:

let
  shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#Scorpius";
    ns = "nix-shell";
    l = "ls -CF";
    ll = "ls -la";
    cl = "clear";
    tree = "tree -I node_modules -I __pycache__";

    dir = "dir --color=auto";
    vdir = "vdir --color=auto";

    grep = "grep --color=auto";
    fgrep = "fgrep --color=auto";
    egrep = "egrep --color=auto";
  };
in {
  programs.bash = {
    enable = true;
    shellAliases = shellAliases;
    initExtra = builtins.readFile ../config/shell/bashrc.sh;
    profileExtra = builtins.readFile ../config/shell/profile.sh;
  };
}
