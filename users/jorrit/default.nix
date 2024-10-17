#    _                 _ _
#   (_) ___  _ __ _ __(_) |_
#   | |/ _ \| '__| '__| | __|
#   | | (_) | |  | |  | | |_
#  _/ |\___/|_|  |_|  |_|\__|
# |__/
#
# Home configuration for jorrit.
{
  config,
  inputs,
  pkgs,
  ...
}: let
  backgroundPaths = {
    dark = "file:///home/jorrit/Pictures/Backgrounds/night.jpg";
    light = "file:///home/jorrit/Pictures/Backgrounds/day.jpg";
  };

  gnomeConfig = import ../../modules/home-manager/gnome {
    inherit config inputs pkgs backgroundPaths;
  };
in {
  imports = [
    gnomeConfig
    ./impermanence.nix
  ];

  # User configuration

  home = {
    username = "jorrit";
    homeDirectory = "/home/jorrit";
    packages = with pkgs; [
      # Apps
      brave
      dbeaver-bin
      discord
      figlet
      fzf
      gthumb
      inkscape
      obsidian
      pinta
      postman
      signal-desktop
      spotify
      teams-for-linux
      vscode

      # Fonts
      cascadia-code
      inter
      meslo-lgs-nf
      roboto

      # Other
      android-tools
    ];
  };

  # Programs configuration

  ## Git
  programs.git = {
    enable = true;
    userName = "jorrit";
    userEmail = "35707261+jorritvanderheide@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
      safe.directory = ["/etc/nixos"];
    };
  };
}
