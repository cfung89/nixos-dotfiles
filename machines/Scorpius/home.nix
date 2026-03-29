{ config, pkgs, isWSL, ... }:

{
  imports = [
    ../../common/home.nix
    ../../modules/sway.nix
    ../../modules/swaylock.nix
    ../../modules/swayidle.nix
  ];

  home.packages = [
    pkgs.discord
    pkgs.ghostty
    pkgs.grim
    pkgs.obsidian
    pkgs.signal-desktop
    pkgs.slurp
    pkgs.rofi-wayland
    pkgs.rofi-calc
    pkgs.libqalculate
    pkgs.zathura
  ];

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

  programs.waybar.enable = true;
}
