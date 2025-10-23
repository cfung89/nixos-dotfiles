{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  security.polkit.enable = true;
  security.pam.services.swaylock = { };
  services.dbus.enable = true;
  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;
  hardware.graphics.enable = true; # GPU acceleration

  # Networking
  networking.hostName = "Scorpius";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Montreal";

  # Printing (CUPS)
  services.printing.enable = true;

  # User
  users.users.cyrus = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
    packages = with pkgs; [ tree ];
  };

  # Settings for flameshot
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    config.common.default = "*";
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

  # SSH
  services.openssh.enable = true;

  # Display/xserver
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "nouveau" ]; # [ "nvidia" ]

  # services.getty.autologinUser = "cyrus";

  # Greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway";
        user = "cyrus";
      };
    };
  };
  environment.etc."greetd/environments".text = ''
    sway
    bash
  '';

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

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    foot
    wget
    libreoffice
    adwaita-icon-theme
    xorg.xcursorthemes
  ];

  environment.variables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05";
}

