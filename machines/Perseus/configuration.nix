{ config, lib, pkgs, isWSL, ... }:

{
  imports = [ ./hardware-configuration.nix ../../common/configuration.nix ];

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
}

