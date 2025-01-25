# Hardware configuration for Radboud
{inputs, ...}: {
  imports = [
    # inputs.nixos-hardware.nixosModules.<device-nname> # Import community hardware module
    ./hardware.nix
  ];

  # Enable TPM
  boot.initrd.availableKernelModules = ["tpm_tis"];

  # Hardware
  hardware = {
    # Logitech Bolt
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    # Sensors
    sensor.iio.enable = true;
  };

  # Services
  services = {
    # ## Driver updates - See if supported
    # fwupd = {
    #   enable = true;
    #   extraRemotes = ["lvfs-testing"]; # See https://github.com/NixOS/nixos-hardware/tree/master/framework
    # };

    ## Power
    power-profiles-daemon.enable = false;
    auto-cpufreq.enable = true;
    auto-cpufreq.settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "default";
        turbo = "never";
      };
    };
  };
}
