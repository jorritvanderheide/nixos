# System module that configures the disk layout and ZFS settings using Disko
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mySystem.disks;
in {
  imports = [
    inputs.disko.nixosModules.default
  ];

  options.mySystem.disks = {
    zfs = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      hostId = lib.mkOption {
        type = lib.types.str;
        default = "";
      };
      encrypt = lib.mkOption {
        type = lib.types.bool;
        default = true;
      };
      disk = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = ''
          device name
        '';
      };
      reservation = lib.mkOption {
        type = lib.types.str;
        default = "32G";
        description = ''
          zfs reservation
        '';
      };
      swap = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = ''
            whether a swap file should be used
          '';
        };
        size = lib.mkOption {
          type = lib.types.str;
          default = "32G"; # Should be RAM * 2 in most cases
          description = ''
            swapfile size
          '';
        };
      };
    };
  };

  config = lib.mkMerge [
    # Defaut
    (lib.mkIf cfg.enable {
      boot.loader.systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      boot.loader.efi.canTouchEfiVariables = true;
    })

    # Zfs
    (lib.mkIf cfg.zfs.enable {
      networking.hostId = cfg.zfs.hostId;
      environment.systemPackages = [pkgs.zfs-prune-snapshots];
      boot = {
        kernelParams = [
          "nohibernate"
          "zfs.zfs_arc_max=17179869184"
        ];
        supportedFilesystems = ["vfat" "zfs"];
        zfs = {
          devNodes = "/dev/disk/by-id/";
          forceImportAll = true;
          requestEncryptionCredentials = true;
        };
      };
      services.zfs = {
        autoScrub.enable = true;
        trim.enable = true;
      };

      disko.devices = {
        disk.main = {
          device = "/dev/${cfg.zfs.disk}";
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "2G";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [
                    "defaults"
                    "umask=0077"
                  ];
                };
              };
              luks = lib.mkIf cfg.zfs.encrypt {
                size = "100%";
                content = {
                  type = "luks";
                  name = "crypted";
                  settings.allowDiscards = true;
                  passwordFile = "/tmp/secret.key";
                  content = {
                    type = "zfs";
                    pool = "zroot";
                  };
                };
              };
              notluks = lib.mkIf (!cfg.zfs.encrypt) {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };
        zpool = {
          zroot = {
            type = "zpool";
            rootFsOptions = {
              canmount = "off";
              checksum = "edonr";
              compression = "zstd";
              dnodesize = "auto";
              mountpoint = "none";
              normalization = "formD";
              relatime = "on";
              "com.sun:auto-snapshot" = "false";
            };
            options = {
              ashift = "12";
              autotrim = "on";
            };
            datasets = {
              reserved = {
                options = {
                  canmount = "off";
                  mountpoint = "none";
                  reservation = "${cfg.zfs.reservation}";
                };
                type = "zfs_fs";
              };
              root = {
                type = "zfs_fs";
                options.mountpoint = "legacy";
                options."com.sun:auto-snapshot" = "false";
                mountpoint = "/";
                postCreateHook = ''
                  zfs snapshot zroot/root@empty
                '';
              };
              nix = {
                type = "zfs_fs";
                options.mountpoint = "legacy";
                mountpoint = "/nix";
                options = {
                  atime = "off";
                  canmount = "on";
                  "com.sun:auto-snapshot" = "false";
                };
                postCreateHook = "zfs snapshot zroot/nix@empty";
              };
              persist = {
                type = "zfs_fs";
                options.mountpoint = "legacy";
                mountpoint = "/persist";
                options."com.sun:auto-snapshot" = "false";
                postCreateHook = "zfs snapshot zroot/persist@empty";
              };
              swap = lib.mkIf (cfg.zfs.swap.enable) {
                type = "zfs_fs";
                # size = cfg.zfs.swap.size; # Fixme
                options = {
                  mountpoint = "none";
                  swap = "on";
                };
                postCreateHook = "zfs set compression=off zroot/swap";
              };
            };
          };
        };
      };
    })

    # Impermanence
    (lib.mkIf config.mySystem.impermanence.enable {
      boot.initrd.systemd.enable = true;
      boot.initrd.systemd.services.rollback = {
        description = "Rollback ZFS root subvolume to a pristine state";
        wantedBy = [
          "initrd.target"
        ];
        after = [
          "systemd-cryptsetup@enc.service"
        ];
        before = [
          "sysroot.mount"
        ];
        unitConfig.DefaultDependencies = "no";
        serviceConfig.Type = "oneshot";
        script = ''
          zpool import zroot
          zfs rollback -r zroot/root@empty
        '';
      };
    })
  ];
}
