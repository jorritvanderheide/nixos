# System configuration for Framework
{...}: {
  imports = [
    ./hardware
  ];

  config = {
    # mySystem configuration
    mySystem = {
      ## Features
      core.enable = true;
      impermanence.enable = true;
      nix.enable = true;
      # secrets.enable = true;
      secure-boot.enable = true;
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

      ### Networking
      networking = {
        enable = true;
        hostName = "framework";
        firewall.enable = false;
      };

      ### Users
      # TODO: cleanup module
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
  };
}
