# Home manager module that configures Hyprland
{pkgs, ...}: {
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
      # exec-once = [
      #   # Authentication agent
      #   "systemctl - -user start hyprpolkitagent"

      #   # Waybay
      #   "waybar"

      #   # Wallpaper
      #   "swww-daemon & sleep 0.5 && ${pkgs.bash}/bin/bash /etc/nixos/modules/home/features/hyprland/scripts/set-wallpaper.sh &"

      #   # Clipboard
      #   "wl-paste --type text --watch cliphist store" # Stores only text data
      #   "wl-paste --type image --watch cliphist store" # Stores only image data

      #   # Automatic disk mouning
      #   "udiskie"
      # ];

      monitor = [
        "eDP-1, 2256x1504@60, 0x0, 1.175"
        "DP-1, preferred, 2256x-1128, 1"
      ];

      general = {
        gaps_in = 10;
        gaps_out = 20;

        border_size = 2;

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      gestures = {
        workspace_swipe = true;
      };
    };
  };
}
