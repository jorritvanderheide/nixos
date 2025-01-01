# System module that configures a standard Gnome setup
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mySystem.gnome;
in {
  options.mySystem.gnome = {
    excludePackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = ''
        packages to exclude
      '';
    };
  };

  config = {
    # Packages to exclude from install
    environment.gnome.excludePackages = cfg.excludePackages;

    # Enable Gnome
    services = {
      xserver = {
        enable = true;
        excludePackages = with pkgs; [
          xterm
        ];
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };

    # Conditional persist
    mySystem = lib.mkIf config.mySystem.impermanence.enable {
      impermanence.directories = [
        "/var/lib/AccountsService"
      ];
    };
  };
}
