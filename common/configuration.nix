{ config, lib, pkgs, isWSL, ... }:

{
  nixpkgs.config.allowUnfree = true;

  security.polkit.enable = true;
  programs.dconf.enable = true;
  programs.nix-ld.enable = true;
  services.dbus.enable = true;
  hardware.graphics.enable = true;

  time.timeZone = "America/Montreal";

  # Printing (CUPS)
  services.printing.enable = true;

  # User
  users.users.cyrus = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" "seat" ];
    packages = with pkgs; [ tree ];
  };

  documentation.man.enable = true;
  systemd.tmpfiles.rules = [
    "d /var/cache/man 0755 root root -"
    "d /var/cache/man/nixos 0755 root root -"
  ];

  # SSH
  services.openssh.enable = true;

  services.xserver.displayManager.lightdm.enable = false;
  services.displayManager.sddm.enable = false;
  systemd.services.display-manager.enable = false;

  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  environment.systemPackages = with pkgs; [
    vim
    foot
    wget
    adwaita-icon-theme
    man-db
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

