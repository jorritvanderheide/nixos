{pkgs, ...}: {
  imports = [
    ./hardware
  ];

  config = {
    # mySystem configuration
    mySystem = {
      ## Features
      fish.enable = true;
      format.enable = true;
      home.enable = true;
      impermanence.enable = true;
      secure-boot.enable = true;

      ### Disks
      disks = {
        enable = true;
        zfs = {
          hostId = "6812df18";
          encrypt = true;
          disk = "nvme0n1";
        };
      };

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
          xterm
          yelp
        ];
      };

      # TODO: cleanup
      users.enable = true;
      home-users = {
        "jorrit" = {
          userConfig = ./users/jorrit.nix;
          userSettings = {
            initialPassword = "10220408";
          };
        };
      };
    };

    # End of config
    system.stateVersion = "24.11"; # Do not change
  };
}
