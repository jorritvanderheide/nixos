
{pkgs, ...}: {
  # Enable Gnome
  services = {
    xserver.enable = true;
    xserver.displayManager.gdm.enable = true;
    xserver.desktopManager.gnome.enable = true;
  };

  # Eclude packages
  environment.gnome.excludePackages = with pkgs; [
    baobab
    epiphany
    geary
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-connections
    gnome-console
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-tour
    gnome-weather
    gnome-text-editor
    simple-scan
    totem
    xterm
    yelp
  ];
}
