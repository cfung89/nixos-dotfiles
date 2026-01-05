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

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = false;
}

