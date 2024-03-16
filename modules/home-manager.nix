# Home manager configuration

{ config, pkgs, ... }:

{
  imports =
    [
        <home-manager/nixos>
    ];

  home-manager.users.jorrit = {
    # The home.stateVersion option does not have a default and must be set1
    home.stateVersion = "23.11";

    #  Configure programs
    programs.git = { # Git
      enable = true;
      userName  = "Jorrit van der Heide";
      userEmail = "jorritvanderheide@pm.me";
    };
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [
        { name = "hydro"; src = pkgs.fishPlugins.hydro.src; }
        { name = "sponge"; src = pkgs.fishPlugins.sponge.src; }
      ];
    };

    # Dconf settings
    dconf.settings = {
      "org/gnome/mutter" = {
        center-new-windows = true;
        experimental-features = [ "scale-monitor-framebuffer" ];
      };
    };
  };
}