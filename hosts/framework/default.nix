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

      ### DNS over HTTPS
      networking = {
        enable = true;
        dns = {
          enable = true;
          servers = [ "mullvad-all-doh" ];
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
