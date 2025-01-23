# Home manager module that configures GTK theming and Stylix
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  home.packages = with pkgs; [
    gnome-tweaks
  ];

  gtk.enable = true;

  gtk = {
    # TODO: find shell theme
    # theme = {
    #   package = pkgs.rose-pine-gtk-theme;
    #   name = "Rosé Pine Moon";
    # };
    iconTheme = {
      package = pkgs.tela-circle-icon-theme;
      name = "Tela-circle";
    };
  };

  stylix = lib.mkDefault {
    enable = true;
    autoEnable = true;
    image = builtins.path {path = ../../../assets/images/wallpaper-dark.jpg;};
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
  };
}
