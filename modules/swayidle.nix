{ config, pkgs, lib, ... }:

{
  services.swayidle = let
    lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
    display = status: "swaymsg 'output * power ${status}'";
  in {
    enable = true;
    timeouts = [
      {
        timeout = 600; # in seconds
        command =
          "${pkgs.libnotify}/bin/notify-send 'Locking in 30 seconds' -t 30000";
      }
      {
        timeout = 630;
        command = lock;
      }
      {
        timeout = 900;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 930;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
    events = [
      {
        event = "before-sleep";
        # adding duplicated entries for the same event may not work
        command = (display "off") + "; " + lock;
      }
      {
        event = "after-resume";
        command = display "on";
      }
      {
        event = "lock";
        command = (display "off") + "; " + lock;
      }
      {
        event = "unlock";
        command = display "on";
      }
    ];
  };
}
