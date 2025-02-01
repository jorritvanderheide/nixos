# System configuration for Radboud
{
  pkgs,
  ...
}: {
  imports = [
    ./hardware
  ];

  config = {
    # mySystem configuration
    mySystem = {
      ## Features
      format.enable = true;
      home.enable = true;
      impermanence.enable = true;
      # secrets.enable = true;
      # secure-boot.enable = true;
      virtualization.enable = true;

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
          yelp
        ];
      };

      # Users
      # TODO: cleanup module
      users.enable = true;
      home-users = {
        "jorrit" = {
          userConfig = ./users/jorrit.nix;
          userSettings = {
            initialPassword = "10220408";
            # hashedPasswordFile = config.sops.secrets.jorrit_login.path;
          };
        };
      };
    };

    # Networking
    networking.hostName = "radboud";
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
