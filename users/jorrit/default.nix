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
      inter
      meslo-lgs-nf

      ## CLI
      figlet
    ];

    # myHome configuration
    myHome = {
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
        "nvidia-persistenced"
        "nvidia-settings"
        "nvidia-x11"
        "obsidian"
        "spotify"
        "steam"
        "steam-original"
        "steam-unwrapped"
        "steam-run"
        "vscode"
      ];

    # End of config
    home.stateVersion = "24.11"; # Do not change
  };
}
