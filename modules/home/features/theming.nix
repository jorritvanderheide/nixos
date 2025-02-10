# Home manager module that configures GTK theming and Stylix
{ config,
  inputs,
  lib,
  pkgs,
  ...
}: with lib; {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  stylix = lib.mkDefault {
    enable = true;
    autoEnable = true;
    image = builtins.path {path = ../../../assets/images/wallpaper-dark.jpg;}; # Disable when https://github.com/danth/stylix/pull/717 is merged
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
    };
    fonts = {
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      monospace = {
        package = pkgs.cascadia-code;
        name = "Cascadia Code";
      };
      sansSerif = {
        package = pkgs.open-sans;
        name = "Open Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sizes = {
        applications = 11;
        desktop = 11;
        popups = 10;
        terminal = 11;
      };
    };
    iconTheme = {
      enable = true;
      package = pkgs.tela-circle-icon-theme;
      light = "Tela-circle-light";
      dark = "Tela-circle-dark";
    };
    targets = {
      firefox.enable = false;
      vscode.enable = false;
    };
  };

  # Conditionally persist directories
  # Temporary fix for backup error when switching home-manager
  myHome = mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/gtk-3.0"
      ".config/gtk-4.0"
    ];
  };
}
