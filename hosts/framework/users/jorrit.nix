{
  lib,
  outputs,
  pkgs,
  ...
}: {
  imports = [
    outputs.homeManagerModules.default
  ];

  config = {
    # Home
    home.username = "jorrit";
    home.homeDirectory = lib.mkDefault "/home/jorrit";

    # Packages
    home.packages = with pkgs; [
      ## Fonts
      cascadia-code
      inter

      ## CLI
      figlet

      # Themes
      tela-circle-icon-theme
    ];

    # myHome configuration
    myHome = {
      ## Features
      blackbox.enable = true;
      brave.enable = true;
      direnv.enable = true;
      fish.enable = true;
      impermanence.enable = true;
      signal.enable = true;
      vscode.enable = true;

      ### Git
      git = {
        enable = true;
        userName = "jorritvanderheide";
        userEmail = "35707261+jorritvanderheide@users.noreply.github.com";
      };

      ### Gnome
      gnome = {
        enable = true;
        gnomeExtensions = with pkgs; [
          # TODO: Gnome extensions use dconf for configuration. This still needs to be modularized.
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
      };
    };
  };
}
