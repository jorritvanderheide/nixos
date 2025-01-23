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

    environment.systemPackages = with pkgs; [
      dconf-editor
      gnome-tweaks
    ];

    # Enable Gnome
    services = {
      xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };

    # Open any terminal from Nautilus
    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "blackbox";
    };

    # Conditional persist
    mySystem.impermanence = lib.mkIf config.mySystem.impermanence.enable {
      directories = [
        "/var/lib/AccountsService"
      ];
    };
  };
}
