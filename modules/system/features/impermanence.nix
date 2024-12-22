{
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.mySystem.impermanence;
in {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  options.mySystem.impermanence = {
    directories = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Directories to persist";
    };
    files = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "Files to persist";
    };
  };

  config = {
    # Allow home-manager to modify user directories
    programs.fuse.userAllowOther = true;

    # Configure boot
    fileSystems."/persist".neededForBoot = true;

    # Setup persistence directories
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories =
        [
          "/etc/NetworkManager/system-connections"
          "/etc/nixos"
          "/var/lib/bluetooth"
          "/var/lib/fprint"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/var/log"
        ]
        ++ cfg.directories;
      files =
        [
          "/etc/machine-id"
          { file = "/etc/nix/id_rsa"; parentDirectory = { mode = "0700"; }; }
        ]
        ++ cfg.files;
    };
  };
}