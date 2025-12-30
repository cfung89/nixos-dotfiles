{ config, pkgs, ... }:

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
  flameshot-wlr = pkgs.flameshot.override { enableWlrSupport = true; };
in {
  imports = [
    ./modules/shell.nix
    ./modules/sway.nix
    ./modules/swaylock.nix
    ./modules/swayidle.nix
    ./modules/languages.nix
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
    MANPATH = "${pkgs.man-db}/share/man:${pkgs.man-pages}/share/man";
  };
  home.packages = [
    pkgs.cargo
    pkgs.curl
    pkgs.discord
    pkgs.fastfetch
    flameshot-wlr
    pkgs.feh
    pkgs.ghostty
    pkgs.btop
    pkgs.neovim
    pkgs.nodejs
    pkgs.obsidian
    pkgs.ripgrep
    pkgs.signal-desktop
    pkgs.tmux
    pkgs.wl-clipboard
    pkgs.rofi
    pkgs.zathura

    # pkgs.gcc
    # pkgs.jdk
    # pkgs.luajit
    # pkgs.python3
  ];

  programs.fzf = {
    enable = true;
    enableFishIntegration = false;
  };

  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [ ];
    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--disable-features=WaylandWpColorManagerV1"
    ];
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
