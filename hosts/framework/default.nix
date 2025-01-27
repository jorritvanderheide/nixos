# System configuration for Framework
{ ... }: {
  imports = [
    ./hardware
  ];

  config = {
    # mySystem configuration
    mySystem = {
      ## Features
      core.enable = true;
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

    # Networking
    networking.hostName = "framework";
  };
}
