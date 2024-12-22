
{
  lib,
  outputs,
  pkgs,
  ...
}: {
  # Home
  home.username = "jorrit";
  home.homeDirectory = lib.mkDefault "/home/jorrit";

  # Packages
  home.packages = with pkgs; [
    brave
    vscodium
    
    ## Fonts
    cascadia-code
    inter

    ## CLI
    figlet
  ];

  # myHome config
  myHome = {
    ## Features
    fish.enable = true;
    impermanence.enable = true;
    
    ### Git
    git = {
      enable = true;
      userName = "jorritvanderheide";
      userEmail = "35707261+jorritvanderheide@users.noreply.github.com";
    };

    ### Gnome
    gnome = {
      enable = true;
      backgroundPaths = {
        light = "file://${builtins.toPath ./backgrounds/light.jpg}";
        dark = "file://${builtins.toPath ./backgrounds/dark.jpg}";
      };
    };
  };
}
