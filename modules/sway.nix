{ config, pkgs, lib, ... }:

let mod = "Mod4";
in {
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = mod;
      bars = [{ command = "${pkgs.waybar}/bin/waybar"; }];
      terminal = "ghostty";
      startup = [
        # { command = "${pkgs.numlockx}/bin/numlockx on"; always = true; }
      ];
      window = {
        border = 3;
        titlebar = false;
        commands = [{
          criteria.app_id = "flameshot";
          command =
            "border pixel 0, floating enable, fullscreen disable, move absolute position 0 0";
        }];
      };
      output = {
        "DP-2" = {
          pos = "0 0";
          scale = "1.0";
        };
        "DP-3" = {
          pos = "3840 540";
          scale = "1.0";
        };
      };
      workspaceOutputAssign = let
        first = "DP-2";
        second = "DP-3";
      in [
        {
          output = first;
          workspace = "1";
        }
        {
          output = second;
          workspace = "2";
        }
        {
          output = second;
          workspace = "3";
        }
      ];
      keybindings = lib.attrsets.mergeAttrsList [
        (lib.attrsets.mergeAttrsList (map (num:
          let ws = toString num;
          in {
            "${mod}+${ws}" = "workspace ${ws}";
            "${mod}+Shift+${ws}" = "move container to workspace ${ws}";
          }) [ 1 2 3 4 5 6 7 8 9 ]))
        (lib.attrsets.concatMapAttrs (key: direction: {
          "${mod}+${key}" = "focus ${direction}";
          "${mod}+Shift+${key}" = "move ${direction}";
        }) {
          h = "left";
          j = "down";
          k = "up";
          l = "right";
        })
        {
          # Terminal
          "${mod}+Return" = "exec --no-startup-id ${pkgs.ghostty}/bin/ghostty";

          # Browser
          "${mod}+b" =
            "exec ${pkgs.brave}/bin/brave --enable-features=UseOzonePlatform --ozone-platform=wayland";

          # Menu and Applications
          "${mod}+d" =
            "exec ${pkgs.rofi}/bin/rofi -show drun -show-icons -monitor DP-2";
          "${mod}+q" = "kill";

          # System and display
          "${mod}+f" = "fullscreen toggle";
          "${mod}+r" = "mode resize";
          "${mod}+Shift+r" = "exec swaymsg reload";
          "${mod}+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
          "${mod}+Shift+s" =
            "exec --no-startup-id flameshot gui -c -p ~/Documents/Screenshots";
          "${mod}+x" = "exec ${pkgs.swaylock}/bin/swaylock";
          "${mod}+c" = "exec ${pkgs.systemd}/bin/systemctl suspend";
          "${mod}+o" = "exec ${pkgs.systemd}/bin/systemctl reboot";
          "${mod}+p" = "exec ${pkgs.systemd}/bin/systemctl poweroff";

          # Navigation
          "${mod}+Tab" = "workspace next";
          "${mod}+Shift+Tab" = "workspace prev";
          "${mod}+bracketright" = "workspace next";
          "${mod}+bracketleft" = "workspace prev";

          # Audio control
          "XF86AudioRaiseVolume" =
            "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
          "XF86AudioLowerVolume" =
            "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
          "XF86AudioMute" =
            "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

          # Mic control
          "${mod}+XF86AudioRaiseVolume" =
            "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 2%+";
          "${mod}+XF86AudioLowerVolume" =
            "exec ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 2%-";
          "${mod}+XF86AudioMute" =
            "exec ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        }
      ];
      modes = {
        resize = {
          Escape = "mode default";
          Return = "mode default";
          "j" = "resize grow height 5 px or 5 ppt";
          "h" = "resize shrink width 5 px or 5 ppt";
          "l" = "resize grow width 5 px or 5 ppt";
          "k" = "resize shrink height 5 px or 5 ppt";
        };
      };
    };
    extraConfig = ''
      include /etc/sway/config.d/*
      seat seat0 xcursor_theme Adwaita 24

      input "1133:16493:Logitech_M705" {
        # scroll_factor 1.5
      }
    '';
  };
}
