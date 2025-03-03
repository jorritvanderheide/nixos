# Home manager module that configures Hyprland keybindings
{...}: {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";

    bind = [
      "$mod, Return, exec, uwsm app -- blackbox"
      "$mod, F, exec, uwsm app -- firefox"
      "$mod, C, exec, uwsm app -- code"
      "$mod, E, exec, uwsm app -- nautilus"
      "$mod, Q, killactive"
      "$mod SHIFT, C, exec, uwsm app -- hyprpicker -a"
      "$mod, V, exec, cliphist list | uwsm app -- $(wofi --show dmenu) | cliphist decode | wl-copy"
      "$mod CTRL, left, exec, hyprnome --previous --no-empty-before"
      "$mod CTRL, right, exec, hyprnome --no-empty-before"
      "$mod CTRL SHIFT, left, exec, hyprnome --previous --move --no-empty-before"
      "$mod CTRL SHIFT, right, exec, hyprnome --move --no-empty-before"
      "$mod CTRL SHIFT, Q, exec, hyprctl dispatch exit"
      "$mod, R, exec, hyprctl reload"
      "$mod SHIFT, T, exec, sh /etc/nixos/modules/home/features/hyprland/scripts/set-wallpaper.sh toggle"

      "$mod, space, togglespecialworkspace, special"
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      "$mod SHIFT, space, movetoworkspace, special"
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"
    ];

    bindr = [
      "$mod, SUPER_L, exec, pkill wofi || uwsm app -- $(wofi --show drun --define=drun-print_desktop_file=true)"
    ];

    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];

    bindl = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];
  };
}
