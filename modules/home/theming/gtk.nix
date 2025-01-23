# Home manager module that configures GTK
{pkgs, ...}: {
  gtk.enable = true;

  gtk = {
    iconTheme = {
      package = pkgs.tela-circle-icon-theme;
      name = "Tela-circle";
    };
  };
}
