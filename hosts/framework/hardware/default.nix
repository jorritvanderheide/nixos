# Hardware configuration for Framework
{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13th-gen-intel # Import community hardware module
    ./hardware.nix
  ];

  # Enable TPM
  boot.initrd.availableKernelModules = ["tpm_tis"];

  # Sensors
  hardware.sensor.iio.enable = true;
  # TODO: Fix blacklisted hid-sensor-hub kernel module on 6.6.66 LTS

  # Services
  services = {
    ## Driver updates
    fwupd.enable = true;

    ## Fingerprint
    fprintd.enable = true;

    ## Power management
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
