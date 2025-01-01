# Home manager module that configures GTK theming
{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
  ];

  gtk.enable = true;

  gtk = {
    # TODO: find cursor and shell theme
    # cursorTheme = {
    #   package = pkgs.oreo-cursors-plus;
    #   name = "Oreo_spark_black_border_cursors";
    # };
    # theme = {
    #   package = pkgs.marble-shell-theme;
    #   name = "Orchis-Purple";
    # };
    iconTheme = {
      package = pkgs.tela-circle-icon-theme;
      name = "Tela-circle";
    };
  };
}
