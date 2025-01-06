# User configuration for Jorrit
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
    ];

    # myHome configuration
    myHome = {
      ## Features
      blackbox.enable = true;
      brave.enable = true;
      direnv.enable = true;
      fish.enable = true;
      impermanence.enable = true;
      obsidian.enable = true;
      signal.enable = true;
      spotify.enable = true;
      theming.enable = true;
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

    # Allow as unfree package
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [
        "spotify"
        "vscode"
      ];

    # End of config
    home.stateVersion = "24.11"; # Do not change
  };
}
