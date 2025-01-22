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
    opacity = {
      applications = 0.95;
      popups = 0.95;
      terminal = 0.95;
    };
    cursor = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 11;
    };
    fonts = {
      monospace = {
        package = pkgs.cascadia-code;
        name = "Cascadia Code";
      };
      sansSerif = {
        package = pkgs.cantarell-fonts;
        name = "Cantarel";
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
