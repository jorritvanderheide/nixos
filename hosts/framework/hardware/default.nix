# Hardware configuration for Framework
{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13th-gen-intel # Import community hardware module
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
    ## Driver updates
    fwupd = {
      enable = true;
      extraRemotes = ["lvfs-testing"]; # See https://github.com/NixOS/nixos-hardware/tree/master/framework
    };
  };
}
