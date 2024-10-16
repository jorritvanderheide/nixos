#  _               _
# | |__   ___  ___| |_ _ __   __ _ _ __ ___   ___
# | '_ \ / _ \/ __| __| '_ \ / _` | '_ ` _ \ / _ \
# | | | | (_) \__ \ |_| | | | (_| | | | | | |  __/
# |_| |_|\___/|___/\__|_| |_|\__,_|_| |_| |_|\___|
#
#
# Host configuration for hostname.
{...}: let
  diskoConfig = import ./disko.nix {device = "/dev/nvme0n1";};

  imports = [
    ./hardware-configuration.nix
  ];
in {
  # TODO: remove
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
  # End TODO

  # Set hostname
  networking = {
    hostName = "hostname";
  };
}
