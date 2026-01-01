{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../../common/configuration.nix ];

  # Networking
  networking.hostName = "Perseus";
  networking.networkmanager.enable = false;

  # Display/xserver
  services.xserver.enable = false;
}

