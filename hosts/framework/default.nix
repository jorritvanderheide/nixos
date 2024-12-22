{ config, ... }:
{
  imports = [
    ./hardware.nix
  ];

  config = {
    # System configuration
    mySystem = {
      ## Features
      nix.enable = true;
      gnome.enable = true;
      impermanence.enable = true;

      disks = {
        enable = true;
        zfs = {
          hostId = "6812df18";
          encrypt = true;
          disk = "nvme0n1";
        };
        impermanence.enable = true;
      };

      users.enable = true;
      home-users = {
        "jorrit" = {
          userConfig = ./users/jorrit;
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
