# System module that configures a standard Gnome setup
{
  config,
  lib,
  ...
}: let
  cfg = config.mySystem.gnome;
in {
  options.mySystem.gnome = {
    excludePackages = lib.mkOption {
      # type = lib.types.listOf lib.types.pkgs; # TODO: fix type
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
      xserver.enable = true;
      xserver.displayManager.gdm.enable = true;
      xserver.desktopManager.gnome.enable = true;
    };
  };
}
