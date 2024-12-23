{...}: {
  dconf.settings = {
    # Remove unused bindings
    "org/gnome/desktop/wm/keybindings" = {
      activate-window-menu = [];
      begin-move = [];
      begin-resize = [];
      cycle-group = [];
      cycle-group-backward = [];
      cycle-panels = [];
      cycle-panels-backward = [];
      cycle-windows = [];
      cycle-windows-backward = [];
      minimize = [];
      move-to-monitor-down = [];
      move-to-monitor-up = [];
      move-to-workspace-down = [];
      move-to-workspace-last = [];
      move-to-workspace-up = [];
      switch-applications-backward = [];
      switch-group = [];
      switch-group-backward = [];
      switch-input-source = [];
      switch-input-source-backward = [];
      switch-panels = [];
      switch-panels-backward = [];
      switch-to-workspace-1 = [];
      switch-to-workspace-2 = [];
      switch-to-workspace-3 = [];
      switch-to-workspace-4 = [];
      switch-to-workspace-last = [];
      switch-to-workspace-up = [];
      toggle-maximized = [];
    };

    "org/gnome/mutter/wayland/keybindings" = {
      restore-shortcuts = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      help = [];
      magnifier = [];
      magnifier-zoom-in = [];
      magnifier-zoom-out = [];
      screenreader = [];
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      clear-history = [];
      next-entry = [];
      prev-entry = [];
      private-mode-binding = [];
    };

    "org/gnome/shell/keybindings" = {
      screenshot = [];
      screenshot-window = [];
      focus-active-notification = [];
      show-screen-recording-ui = [];
      toggle-message-tray = [];
    };

    # Set used bindings
    "org/gnome/desktop/wm/keybindings" = {
      close = ["<Super>q"];
      move-to-center = ["<Super>Space"];
      move-to-monitor-left = ["<Super><Alt>Left"];
      move-to-monitor-right = ["<Super><Alt>Right"];
      move-to-side-e = ["<Super>Right"];
      move-to-side-w = ["<Super>Left"];
      move-to-workspace-1 = ["<Shift><Control><Super>1"];
      move-to-workspace-2 = ["<Shift><Control><Super>2"];
      move-to-workspace-3 = ["<Shift><Control><Super>3"];
      move-to-workspace-4 = ["<Shift><Control><Super>4"];
      move-to-workspace-left = ["<Shift><Control><Super>Left"];
      move-to-workspace-right = ["<Shift><Control><Super>Right"];
      panel-run-dialog = ["<Super>r"];
      show-desktop = ["<Super>d"];
      switch-windows = ["<Alt>Tab"];
      switch-to-workspace-left = ["<Control><Super>Left"];
      switch-to-workspace-right = ["<Control><Super>Right"];
      toggle-fullscreen = ["Print"];
      unmaximize = ["<Super>Down"];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = ["<Super>e"];
      next = ["AudioNext"];
      play = ["AudioPlay"];
      previous = ["AudioPrev"];
      www = ["<Super>f"];
    };

    "org/gnome/shell/extensions/clipboard-indicator" = {
      toggle-menu = ["<Super>v"];
    };

    "org/gnome/shell/extensions/nightthemeswitcher" = {
      nightthemeswitcher-ondemand-keybinding = ["<Shift><Super>t"];
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = ["<Shift><Super>s"];
      toggle-overview = ["<Super>Tab"];
      toggle-quick-settings = ["<Super>a"];
    };

    # Set custom keybindings
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>Return";
      command = "blackbox";
      name = "Terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>c";
      command = "code";
      name = "VS Code";
    };
  };
}
