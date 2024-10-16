#  _               _
# | |__   ___  ___| |_ _ __   __ _ _ __ ___   ___
# | '_ \ / _ \/ __| __| '_ \ / _` | '_ ` _ \ / _ \
# | | | | (_) \__ \ |_| | | | (_| | | | | | |  __/
# |_| |_|\___/|___/\__|_| |_|\__,_|_| |_| |_|\___|
#
#
# Host configuration for hostname.
{...}: let
  imports = [
    ./hardware-configuration.nix
  ];
in {
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
      systemd-boot.enable = false;
    };
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}
