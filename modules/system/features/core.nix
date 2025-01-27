# System module that configures core features for any system
{
  pkgs,
  ...
}: {
  config = {
    # mySystem configuration
    mySystem = {
      ## Features
      format.enable = true;
      home.enable = true;
      impermanence.enable = true;
      virtualization.enable = true;

      ### Gnome
      gnome = {
        enable = true;
        excludePackages = with pkgs; [
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
          yelp
        ];
      };
    };

    # Networking
    networking.networkmanager.enable = true;

    # Auto-upgrade
    system.autoUpgrade = {
      enable = true;
      dates = "weekly";
    };

    # Nix
    nix = {
      ## Garbage collect
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 14d";
      };

      ## Settings
      settings = {
        auto-optimise-store = true;
        experimental-features = ["flakes" "nix-command"];
        warn-dirty = false;
      };

      extraOptions = ''
        trusted-users = root jorrit
      ''; # TODO: make modular
    };

    # Nixpkgs
    nixpkgs.config.allowUnfree = true;

    # Time
    time.timeZone = "Europe/Amsterdam";

    # End of config
    system.stateVersion = "24.11"; # Do not change
  };
}
