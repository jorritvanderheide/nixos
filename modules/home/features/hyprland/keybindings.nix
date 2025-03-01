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
      "$mod, SUPER_L, exec, pkill wofi || rofi -show drun -run-command 'uwsm app -- {cmd}'"
      "$mod SHIFT, C, exec, hyprpicker -a"
      "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"

      "$mod, Space, togglespecialworkspace, special"
      "$mod SHIFT, Space, movetoworkspace, special"
      "$mod CTRL, left, exec, hyprnome --previous --no-empty-before"
      "$mod CTRL, right, exec, hyprnome --no-empty-before"
      "$mod CTRL SHIFT, left, exec, hyprnome --previous --move --no-empty-before"
      "$mod CTRL SHIFT, right, exec, hyprnome --move --no-empty-before"
      "$mod CTRL ALT, delete, exec, hyprctl dispatch exit"
      "$mod, R, exec, hyprctl reload"
    ];

    bindel = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      # ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      # ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
    ];

    bindl = [
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      # ", XF86AudioNext, exec, playerctl next"
      # ", XF86AudioPause, exec, playerctl play-pause"
      # ", XF86AudioPlay, exec, playerctl play-pause"
      # ", XF86AudioPrev, exec, playerctl previous"
    ];
  };
}
