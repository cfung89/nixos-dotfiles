{ config, lib, pkgs, isWSL, ... }:

{
  imports = [ ./hardware-configuration.nix ../../common/configuration.nix ];

  security.sudo.wheelNeedsPassword = true;

  # Networking
  networking.hostName = "Perseus";
  networking.networkmanager.enable = false;

  # Display/xserver
  services.xserver.enable = false;

  wsl.enable = true;
  wsl.defaultUser = "cyrus";

  boot.loader = {
    grub.enable = false;
    systemd-boot.enable = false;
  };

  environment.sessionVariables = {
    XDG_RUNTIME_DIR = "/mnt/wslg/runtime-dir";
    WAYLAND_DISPLAY = "wayland-0";
    DISPLAY = ":0"; # For X11 fallback
  };

  system.activationScripts.fix-wslg-socket = {
    text = ''
      # Link the WSLg socket to the standard Linux location as a backup
      mkdir -p /run/user/1000
      ln -sf /mnt/wslg/runtime-dir/wayland-0 /run/user/1000/wayland-0
      ln -sf /mnt/wslg/runtime-dir/wayland-0.lock /run/user/1000/wayland-0.lock
    '';
  };
}
