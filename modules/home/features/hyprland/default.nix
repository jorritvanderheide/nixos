# Home manager module that configures Hyprland
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hyprpanel.nix
    ./keybindings.nix
  ];

  # Configure Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;

    settings = {
      exec-once = [
        # Authentication agent
        "systemctl --user enable --now hyprpolkitagent.service"

        # Bar
        "uwsm app -- hyprpanel"

        # Wallpaper
        "swww-daemon & sleep 0.5 && ${pkgs.bash}/bin/bash /etc/nixos/modules/home/features/hyprland/scripts/set-wallpaper.sh &"

        # Clipboard
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"

        # Automatic disk mouning
        "udiskie"
      ];

      monitor = [
        "eDP-1, 2256x1504@60, 0x0, 1.175"
        "DP-1, preferred, 2256x-1128, 1"
      ];

      general = {
        gaps_in = 10;
        gaps_out = 20;
        border_size = 4;
        "col.active_border" = "rgba(${config.lib.stylix.colors.base0C}ff)";
        "col.inactive_border" = "rgba(${config.lib.stylix.colors.base05}ff)";
        layout = "master";
        resize_on_border = true;
        hover_icon_on_border = true;
      };

      decoration = {
        rounding = 10;

        active_opacity = 0.9;
        inactive_opacity = 0.9;

        blur = {
          enabled = true;
          size = 5;
          xray = true;
          new_optimizations = "on";
          brightness = 0.8;
          contrast = 0.9;
          noise = 0.01;
          passes = 4;
          ignore_opacity = false;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "linear, 0.0, 0.0, 1.0, 1.0"
          "myBezier, 0.05, 0.9, 0.1, 1.05"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "cubic, 0.54, 0.22, 0.07, 0.74"
          "overshotCircle, 0.175, 0.885, 0.32, 1.275"
          "md3_standard, 0.2, 0.0, 0, 1.0"
          "bounce, 1, 1.6, 0.1, 0.85"
          "decel, 0.05, 0.7, 0.1, 1"
        ];

        animation = [
          "windowsIn, 1, 3, bounce, popin 23%"
          "windowsOut, 1, 7, bounce, slide"
          "windows, 1, 2, md3_standard, slide"
          "border, 1, 10, overshot"
          "borderangle, 1, 100, linear, loop"
          "fade, 1, 0.0000001, default"
          "workspaces, 1, 4, decel, slidefade"
        ];
      };

      input = {
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.5;
          drag_lock = true;
        };
      };

      misc = {
        disable_hyprland_logo = true;
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_direction_lock = false;
        workspace_swipe_forever = true;
      };

      # Plugins
      plugin = {
        ## Hyprtrails
        hyprtrails = {
          color = "rgba(${config.lib.stylix.colors.base09}ff)";
        };
      };
    };

    plugins = [
      inputs.hyprland-plugins.packages."${pkgs.system}".hyprtrails
    ];
  };
}
