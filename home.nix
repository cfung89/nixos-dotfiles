{ config, pkgs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    vim = "vim";
    nvim = "nvim";
    tmux = "tmux";
    ghostty = "ghostty";
    waybar = "waybar";
  };
  flameshot-wlr = pkgs.flameshot.override { enableWlrSupport = true; };
in {
  imports = [
    ./modules/shell.nix
    ./modules/sway.nix
    ./modules/swaylock.nix
    ./modules/swayidle.nix
  ];

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
  };
  home.packages = [
    pkgs.cargo
    pkgs.curl
    pkgs.discord
    pkgs.fastfetch
    flameshot-wlr
    pkgs.gcc
    pkgs.ghostty
    pkgs.htop
    pkgs.neovim
    pkgs.nodejs
    pkgs.ripgrep
    pkgs.signal-desktop
    pkgs.tmux
    pkgs.wl-clipboard
    pkgs.rofi
    pkgs.zathura
  ];

  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [ ];
    commandLineArgs = [ "--disable-features=WebRtcAllowInputVolumeAdjustment" ];
  };

  programs.git = {
    enable = true;
    extraConfig.init.defaultBranch = "main";
  };

  programs.waybar.enable = true;

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
