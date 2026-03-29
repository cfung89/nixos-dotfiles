{
  config,
  lib,
  pkgs,
  isWSL,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  services.seatd.enable = true;
  security.pam.services.swaylock = { };

  # Networking
  networking.hostName = "Scorpius";
  networking.networkmanager.enable = true;

  # Printing (CUPS)
  services.printing = {
    enable = true;
    drivers = [ pkgs.samsung-unified-linux-driver ];
  };
  hardware.printers = {
    ensurePrinters = [
      {
        name = "SCX-472x_Series";
        description = "SCX-472x_Series";
        location = "2nd floor";
        deviceUri = "socket://192.168.1.115:9100";
        model = "samsung/SCX-472x.ppd";
        ppdOptions = {
          PageSize = "Letter";
        };
      }
    ];
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
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd 'sway --unsupported-gpu'";
        user = "cyrus";
      };
    };
  };

  environment.variables = {
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = 1;
    XWAYLAND_NO_GLAMOR = 1;
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    XDG_CURRENT_DESKTOP = "sway";
  };

  environment.systemPackages = with pkgs; [
    libreoffice
    xorg.xcursorthemes
  ];
}
