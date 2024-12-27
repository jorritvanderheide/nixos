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
      gnome.enable = true;
      impermanence.enable = true;
      signal.enable = true;
      vscode.enable = true;

      ### Git
      git = {
        enable = true;
        userName = "jorritvanderheide";
        userEmail = "35707261+jorritvanderheide@users.noreply.github.com";
      };
    };

    # End of config
    home.stateVersion = "24.11"; # Do not change
  };
}
