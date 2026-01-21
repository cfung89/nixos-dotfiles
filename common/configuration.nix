{ config, lib, pkgs, isWSL, ... }:

{
  nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;
  programs.dconf.enable = true;
  programs.nix-ld.enable = true;
  services.dbus.enable = true;
  hardware.graphics.enable = true;

  time.timeZone = "America/Montreal";

  # User
  users.users.cyrus = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" "seat" "docker" ];
    packages = with pkgs; [ tree ];
  };

  # Man
  documentation.man.enable = true;
  documentation.man.generateCaches = true;

  # SSH
  services.openssh.enable = true;

  # Display manager
  services.xserver.displayManager.lightdm.enable = false;
  services.displayManager.sddm.enable = false;
  systemd.services.display-manager.enable = false;

  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  # Docker
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    foot
    wget
    adwaita-icon-theme
    man-pages
    man-pages-posix
    zip
    unzip
  ];

  fonts = {
    packages = with pkgs; [
      font-awesome
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      dejavu_fonts
      nerd-fonts.symbols-only
    ];
    fontconfig = {
      defaultFonts.emoji = [ "Noto Color Emoji" ];
      enable = true;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}

