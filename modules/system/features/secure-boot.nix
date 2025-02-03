# System module that configures a secure boot setup using Lanzaboote and Plymouth
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.mySystem.secure-boot;
in {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  options.mySystem.secure-boot = {
    pkiBundlePath = lib.mkOption {
      type = types.str;
      default = "/var/lib/sbctl";
    };
  };

  config = {
    # Disable systemd boot
    boot.loader.systemd-boot.enable = lib.mkForce false;

    # Enable lanzaboote
    boot.lanzaboote = {
      enable = true;
      pkiBundle = cfg.pkiBundlePath;
    };

    # Enable TPM
    boot.initrd.systemd.enable = true;
    security.tpm2.enable = true;
    security.tpm2.tctiEnvironment.enable = true;

    # Quiet boot
    boot.kernelParams = [
      "quiet"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "boot.shell_on_fail"
    ];
    boot.consoleLogLevel = 0;
    boot.initrd.verbose = false;
    boot.plymouth.enable = true;

    # Support packages
    environment.systemPackages = [
      pkgs.sbctl
    ];

    # Conditional persist
    mySystem = lib.mkIf config.mySystem.impermanence.enable {
      impermanence.directories = [
        "/var/lib/sbctl"
        "/etc/secureboot"
      ];
    };
  };
}
