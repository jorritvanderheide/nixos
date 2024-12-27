# Hardware configuration for Framework
{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13th-gen-intel # Import community hardware module
    ./hardware.nix
  ];

  # Enable TPM
  boot.initrd.availableKernelModules = ["tpm_tis"];

  # Packages
  environment.systemPackages = with pkgs; [
    iio-sensor-proxy # Auto-brightness on Gnome
  ];

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
