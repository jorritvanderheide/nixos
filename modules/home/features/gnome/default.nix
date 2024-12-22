{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myHome.gnome;
in {
  imports = [
    ./keybindings.nix
  ];

  options.myHome.gnome = {
    backgroundPaths = lib.mkOption {
      default = {
        light = "";
        dark = "";
      };
      description = "Paths to light and dark background images.";
    };
  };

  config = {
    # Gnome extensions
    home.packages = with pkgs;
      [
        blackbox-terminal
      ]
      ++ [
        gnomeExtensions.alphabetical-app-grid
        gnomeExtensions.appindicator
        gnomeExtensions.blur-my-shell
        gnomeExtensions.burn-my-windows
        gnomeExtensions.caffeine
        gnomeExtensions.clipboard-indicator
        gnomeExtensions.color-picker
        gnomeExtensions.dash-to-dock
        gnomeExtensions.impatience
        gnomeExtensions.mpris-label
        gnomeExtensions.night-theme-switcher
        gnomeExtensions.steal-my-focus-window
        gnomeExtensions.unite
      ];

    # Impermanene
    myHome.impermanence = {
      directories = [
        ".config/burn-my-windows"
      ];
      files = [
        ".config/gnome-initial-setup-done"
      ];
    };

    # Dconf settings
    dconf.settings = {
      "ca/desrt/dconf-editor" = {
        show-warning = false;
      };

      "org/gnome/desktop/background" = {
        picture-uri = cfg.backgroundPaths.light;
        picture-uri-dark = cfg.backgroundPaths.dark;
      };

      "org/gnome/desktop/datetime" = {
        automatic-timezone = true;
      };

      "org/gnome/desktop/interface" = {
        clock-show-date = false;
        enable-hot-corners = false;
        icon-theme = "Tela-circle";
        font-hinting = "none";
        show-battery-percentage = true;
      };

      "org/gnome/desktop/lockdown" = {
        disable-user-switching = true;
      };

      "org/gnome/desktop/screensaver" = {
        lock-enabled = false;
      };

      "org/gnome/desktop/session" = {
        idle-delay = 60;
      };

      "org/gnome/desktop/notifications" = {
        show-in-lock-screen = false;
      };

      "org/gnome/desktop/wm/preferences" = {
        audible-bell = false;
      };

      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        edge-tiling = true;
        experimental-features = ["scale-monitor-framebuffer"];
        workspaces-only-on-primary = true;
      };

      "org/gnome/system/location" = {
        enabled = true;
      };

      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = lib.hm.gvariant.mkUint32 4700;
      };

      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-timeout = 600;
        sleep-inactive-battery-timeout = 600;
      };

      "org/gnome/shell" = {
        welcome-dialog-last-shown-version = "47.0";
        enabled-extensions = [
          "AlphabeticalAppGrid@stuarthayhurst"
          "appindicatorsupport@rgcjonas.gmail.com"
          "blur-my-shell@aunetx"
          "burn-my-windows@schneegans.github.com"
          "caffeine@patapon.info"
          "clipboard-indicator@tudmotu.com"
          "color-picker@tuberry"
          "dash-to-dock@micxgx.gmail.com"
          "impatience@gfxmonk.net"
          "mprisLabel@moon-0xff.github.com"
          "nightthemeswitcher@romainvigier.fr"
          "steal-my-focus-window@steal-my-focus-window"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "unite@hardpixel.eu"
        ];
        favorite-apps = [
          "brave-browser.desktop"
          "code.desktop"
          "obsidian.desktop"
          "spotify.desktop"
        ];
      };

      "org/gnome/shell/app-switcher" = {
        current-workspace-only = true;
      };

      "org/gnome/shell/extensions/blur-my-shell/panel" = {
        override-background-dynamically = true;
      };

      "org/gnome/shell/extensions/burn-my-windows" = {
        active-profile = "/persist/home/jorrit/.config/burn-my-windows/profiles/1718655678027134.conf";
      };

      "org/gnome/shell/extensions/clipboard-indicator" = {
        display-mode = 3;
      };

      "org/gnome/shell/extensions/color-picker" = {
        color-picker-shortcut = ["<Super><Shift>c"];
        default-format = lib.hm.gvariant.mkUint32 0;
        enable-format = true;
        enable-shortcut = true;
        enable-sound = false;
        enable-systray = false;
      };

      "org/gnome/shell/extensions/dash-to-dock" = {
        apply-custom-theme = true;
        disable-overview-on-startup = true;
        hide-tooltip = true;
        hot-keys = false;
        show-icons-emblems = false;
        show-mounts = false;
        show-show-apps-button = false;
        show-trash = false;
      };

      "org/gnome/shell/extensions/mpris-label" = {
        button-placeholder = "";
        divider-string = " - ";
        extension-place = "left";
        left-click-action = "activate-player";
        middle-click-action = "none";
        right-click-action = "none";
        scroll-action = "";
        second-field = "";
        thumb-forward-action = "none";
        thumb-backward-action = "none";
        use-album = false;
      };

      "org/gnome/shell/extensions/unite" = {
        hide-activities-button = "never";
        show-appmenu-button = false;
        show-desktop-name = false;
        show-window-buttons = "never";
        use-activities-text = false;
      };

      "org/gtk/gtk4/settings/file-chooser" = {
        show-directories-first = false;
      };

      # Other dconf apps
      "com/raggesilver/BlackBox" = {
        easy-copy-paste = true;
        remember-window-size = true;
        show-headerbar = false;
        style-preference = lib.hm.gvariant.mkUint32 2;
        terminal-bell = false;
        terminal-padding = with lib.hm.gvariant;
          mkTuple
          [
            (mkUint32 24)
            (mkUint32 24)
            (mkUint32 24)
            (mkUint32 24)
          ];
        theme-dark = "One Dark";
        working-directory-mode = 1;
      };
    };

    # Triple buffering patch for Mutter
    nixpkgs.overlays = [
      (final: prev: {
        gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
          mutter = gnomePrev.mutter.overrideAttrs (old: {
            src = pkgs.fetchFromGitLab {
              domain = "gitlab.gnome.org";
              owner = "vanvugt";
              repo = "mutter";
              rev = "triple-buffering-v4-46";
              hash = "sha256-fkPjB/5DPBX06t7yj0Rb3UEuu5b9mu3aS+jhH18+lpI=";
            };
          });
        });
      })
    ];
  };
}