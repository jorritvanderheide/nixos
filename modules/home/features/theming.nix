# Home manager module that configures GTK theming
{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-tweaks
  ];

  gtk.enable = true;

  gtk = {
    cursorTheme = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
    };
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
}
