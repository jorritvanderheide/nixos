# Home manager module that configures Gnome extensions
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.myHome.gnome;
in {
  # Gnome extensions
  home.packages = with pkgs;
    [
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
    ]
    ++ cfg.gnomeExtensions;

  # Dconf settings
  dconf.settings = {
    "org/gnome/shell" = {
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
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      override-background-dynamically = true;
    };

    "org/gnome/shell/extensions/burn-my-windows" = {
      active-profile = "/home/jorrit/.config/burn-my-windows/profiles/1734873759007423.conf";
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
  };
}
