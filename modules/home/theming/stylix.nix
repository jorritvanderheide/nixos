# Home manager module that configures Stylix
{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

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
