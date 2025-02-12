# System configuration for Radboud
{
  ...
}: {
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
      virtualization.enable = true;

      ### Disks
      disks = {
        enable = true;
        zfs = {
          hostId = "5345cb19";
          encrypt = true;
          disk = "nvme0n1";
          swap = {
            enable = true;
            size = "32G";
          };
        };
      };

      ### Radboud
      networking = {
        enable = true;
        hostName = "radboud";
        firewall.enable = false;
      };

      # Secure boot
      secure-boot = {
        enable = true;
        pkiBundlePath = "/etc/secureboot";
      };

      # Users
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
