{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./disko
  ];

  config = {
    # Custom configurations
    hosts.disks = {
      enable = true;
      zfs = {
        hostId = "fd6b58";
        encrypt = true;
        disk = "nvme0n1";
        impermanence = true;
      };
    };

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "framework";
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Amsterdam";

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    
    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.jorrit = {
      isNormalUser = true;
      initialPassword = "10220408";
      extraGroups = [ "wheel" ];
    };

    # Packages
    environment.systemPackages = with pkgs; [
      brave
      git
      vscodium
    ];

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;

    # End of config
    system.stateVersion = "24.11"; # Do not change
  };
}
