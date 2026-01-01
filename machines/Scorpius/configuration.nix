{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../../common/configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.seatd.enable = true;
  security.pam.services.swaylock = { };

  # Networking
  networking.hostName = "Scorpius";
  networking.networkmanager.enable = true;

  # Settings for flameshot
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr xdg-desktop-portal-gtk ];
    config.common.default = "*";
    configPackages = [ pkgs.xdg-desktop-portal-wlr ];
  };

  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Default browser
  programs.firefox.enable = true;

  # Display/xserver
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nouveau" ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "cyrus";
      };
    };
  };

  # Set up num lock by default on tty
  systemd.services.numLockOnTty = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      # /run/current-system/sw/bin/setleds -D +num < "$tty";
      ExecStart = lib.mkForce (pkgs.writeShellScript "numLockOnTty" ''
        for tty in /dev/tty{1..6}; do
            ${pkgs.kbd}/bin/setleds -D +num < "$tty";
        done
      '');
    };
  };

  environment.variables = {
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = 1;
    XWAYLAND_NO_GLAMOR = 1;
  };

  environment.systemPackages = with pkgs; [
    libreoffice
    xorg.xcursorthemes
    numlockx
  ];
}

