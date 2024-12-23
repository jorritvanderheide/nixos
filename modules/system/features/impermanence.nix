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
      description = ''
        directories to persist
      '';
    };
    files = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = ''
        files to persist
      '';
    };
  };

  config = {
    # Setup persist directories
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
        ]
        ++ cfg.files;
    };

    # Mark as needed for boot
    fileSystems."/persist".neededForBoot = true;

    # Allow home-manager to modify user directories
    programs.fuse.userAllowOther = true;
  };
}
