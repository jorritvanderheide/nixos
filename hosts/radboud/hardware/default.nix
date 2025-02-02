# Hardware configuration for Radboud
{inputs, ...}: {
  imports = [
    # inputs.nixos-hardware.nixosModules.<device-nname> # Import community hardware module
    ./hardware.nix # TODO generate config
  ];

  # Enable TPM
  # boot.initrd.availableKernelModules = ["tpm_tis"]; # TODO Find with sudo systemd-cryptenroll --tpm2-device=list

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
