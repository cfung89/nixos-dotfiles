{ config, pkgs, isWSL, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    vim = "vim";
    nvim = "nvim";
    tms = "tms";
    tmux = "tmux";
    ghostty = "ghostty";
    waybar = "waybar";
    rofi = "rofi";
  };
  targetHost = if isWSL then "WSL-ARM" else "Scorpius";
in {
  imports = [ ../modules/shell.nix ../modules/languages.nix ];

  home.username = "cyrus";
  home.homeDirectory = "/home/cyrus";
  home.stateVersion = "25.05";

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less -FirSwX";
    SSH_ASKPASS = "";
    MANPATH = "${pkgs.man-db}/share/man:${pkgs.man-pages}/share/man";
  };

  home.shellAliases = {
    nrs = "cd ~/nixos-dotfiles/ && git add . && sudo nixos-rebuild switch --flake ~/nixos-dotfiles#${targetHost}";
  };

  home.packages = [
    pkgs.cargo
    pkgs.curl
    pkgs.fastfetch
    pkgs.feh
    pkgs.btop
    pkgs.neovim
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.tmux
    pkgs.wl-clipboard
  ];

  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
  };

  programs.git = {
    enable = true;
    extraConfig.init.defaultBranch = "main";
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
