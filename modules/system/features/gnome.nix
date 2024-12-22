
{config, lib, pkgs, ...}:
let
cfg = config.mySystem.gnome;
in
{
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
    # Exclude packages
    environment.gnome.excludePackages = cfg.excludePackages;

    # Enable Gnome
    services = {
      xserver.enable = true;
      xserver.displayManager.gdm.enable = true;
      xserver.desktopManager.gnome.enable = true;
    };
  };
}
