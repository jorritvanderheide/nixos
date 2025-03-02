# Home manager module that configures Hyprland
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  base16 = pkgs.callPackage inputs.base16.lib {};
  colors = base16.mkSchemeAttrs "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
in {
  imports = [
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
        "systemctl - -user start hyprpolkitagent"

        # Bar
        "hyprpanel"

        # Wallpaper
        "swww-daemon & sleep 0.5 && ${pkgs.bash}/bin/bash /etc/nixos/modules/home/features/hyprland/scripts/set-wallpaper.sh &"

        # Clipboard
        "wl-paste --type text --watch cliphist store" # Stores only text data
        "wl-paste --type image --watch cliphist store" # Stores only image data

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
        "col.active_border" = "rgba(${colors.base0C}ff)";
        "col.inactive_border" = "rgba(${colors.base05}ff)";
        layout = "master";
      };

      decoration = {
        rounding = 10;

        active_opacity = 0.95;
        inactive_opacity = 0.95;

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
        };
      };

      misc = {
        disable_hyprland_logo = true;
      };

      gestures = {
        workspace_swipe = true;
      };

      # Plugins
      plugin = {
        ## Hyprfocus
        # hyprfocus = {
        #   enabled = true;
        #   animate_floating = true;
        #   animate_workspacechange = true;
        #   focus_animation = "shrink";

        #   # Beziers for focus animations
        #   bezier = [
        #     "bezIn, 0.5,0.0,1.0,0.5"
        #     "bezOut, 0.0,0.5,0.5,1.0"
        #     "overshot, 0.05, 0.9, 0.1, 1.05"
        #     "smoothOut, 0.36, 0, 0.66, -0.56"
        #     "smoothIn, 0.25, 1, 0.5, 1"
        #     "realsmooth, 0.28,0.29,.69,1.08"
        #   ];

        #   # Flash settings
        #   flash = {
        #     flash_opacity = 0.95;
        #     in_bezier = "realsmooth";
        #     in_speed = 0.5;
        #     out_bezier = "realsmooth";
        #     out_speed = 3;
        #   };

        #   # Shrink settings
        #   shrink = {
        #     shrink_percentage = 0.95;
        #     in_bezier = "realsmooth";
        #     in_speed = 1;
        #     out_bezier = "realsmooth";
        #     out_speed = 2;
        #   };
        # };

        ## Hyprtrails
        hyprtrails = {
          color = "rgba(${colors.base09}ff)";
        };
      };
    };

    plugins = [
      inputs.hyprland-plugins.packages."${pkgs.system}".hyprtrails
      inputs.Hyprspace.packages."${pkgs.system}".Hyprspace
    ];
  };
}
