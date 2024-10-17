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
    ../../modules/nixos/impermanence
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
  # networking.networkmanager.enable = true;

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

  # Programs
  programs = {
    # SSH
    ssh.startAgent = true;

    # Fish
    fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting
      '';
    };
  };

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

  # User setup
  users.users."jorrit" = {
    isNormalUser = true;
    extraGroups = ["docker" "libvirtd" "networkmanager" "persist" "plugdev" "wheel"];
    initialPassword = "10220408";
    # hashedPasswordFile = config.age.secrets.jorrit.path;
    shell = pkgs.fish;
  };

  # End of config
  system.stateVersion = "24.05"; # Do not change or remove
}
