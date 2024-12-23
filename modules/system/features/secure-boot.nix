{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
  ];

  # Disable systemd boot
  boot.loader.systemd-boot.enable = lib.mkForce false;

  # Enable lanzaboote
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # Support packages
  environment.systemPackages = [
    pkgs.sbctl
  ];

  mySystem = lib.mkIf config.mySystem.impermanence.enable {
    impermanence.directories = [
      "/var/lib/sbctl"
    ];
  };
}
