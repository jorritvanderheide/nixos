# Home manager module that configures the Gnome desktop manager
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./extensions.nix
    ./keybindings.nix
  ];

  options.myHome.gnome = {
    gnomeExtensions = lib.mkOption {
      # type = lib.types.listOf lib.types.pkgs; # TODO: fix type
      default = [];
      description = ''
        extensions to use
      '';
    };
  };

  config = {
    # Conditionally persist directories
    myHome = lib.mkIf config.myHome.impermanence.enable {
      impermanence = {
        directories = [
          ".config/burn-my-windows"
        ];
        files = [
          ".local/share/icc/framework.icm"
        ];
      };
    };

    # Dconf settings
    dconf.settings = {
      "ca/desrt/dconf-editor" = {
        show-warning = false;
      };

      "org/gnome/desktop/background" = {
        picture-uri = "file://${builtins.toPath ../../../../assets/images/wallpaper-light.jpg}";
        picture-uri-dark = "file://${builtins.toPath ../../../../assets/images/wallpaper-dark.jpg}";
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
    };

    # Triple buffering patch for Mutter
    nixpkgs.overlays = [
      (final: prev: {
        gnome = prev.gnome.overrideScope (gnomeFinal: gnomePrev: {
          mutter = gnomePrev.mutter.overrideAttrs (old: {
            src = pkgs.fetchFromGitLab {
              domain = "gitlab.gnome.org";
              hash = "sha256-fkPjB/5DPBX06t7yj0Rb3UEuu5b9mu3aS+jhH18+lpI=";
              owner = "vanvugt";
              repo = "mutter";
              rev = "triple-buffering-v4-46";
            };
          });
        });
      })
    ];
  };
}
