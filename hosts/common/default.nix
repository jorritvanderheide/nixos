#
#   ___ ___  _ __ ___  _ __ ___   ___  _ __
#  / __/ _ \| '_ ` _ \| '_ ` _ \ / _ \| '_ \
# | (_| (_) | | | | | | | | | | | (_) | | | |
#  \___\___/|_| |_| |_|_| |_| |_|\___/|_| |_|
#
#
# Common system configuration for all systems.
{
  config,
  inputs,
  pkgs,
  ...
}: let
  imports = [
    inputs.agenix.nixosModules.age

    ../../modules/impermanence
  ];
in {
  # Nix
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["flakes" "nix-command"];
  };

  # Timezone configuration
  time.timeZone = "Europe/Amsterdam";

  # Setup networking
  networking.networkmanager.enable = true;

  # Graphical services
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    agenix
    alejandra
    git
    home-manager
  ];

  # Services
  services = {
    # SSH
    openssh.enable = true;

    # Printing
    printing.enable = true;
  };

  # Setup Android USB debugging
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", MODE="0666", GROUP="plugdev"
  '';

  # End of config
  system.stateVersion = "24.05"; # Do not change or remove
}
