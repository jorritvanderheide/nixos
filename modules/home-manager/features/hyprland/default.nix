{pkgs, ...}: {
  imports = [
    ./keybindings.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      exec-once = [
        "swww-daemon & sleep 0.5 && ${pkgs.bash}/bin/bash /etc/nixos/modules/home-manager/features/hyprland/scripts/set_wallpaper.sh && ${pkgs.bash}/bin/bash /etc/nixos/modules/home-manager/features/hyprland/scripts/handle_monitor_change.sh &"
      ];

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

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;

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
