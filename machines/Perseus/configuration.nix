{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../../common/configuration.nix ];

  # Networking
  networking.hostName = "Perseus";
  networking.networkmanager.enable = false;

  # Display/xserver
  services.xserver.enable = false;

  wsl.enable = true;
  wsl.defaultUser = "cyrus";

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = false;
}

