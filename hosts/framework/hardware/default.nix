# Hardware configuration for Framework
{inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13th-gen-intel # Import community hardware module # TODO: Fix blacklisted hid-sensor-hub kernel module on 6.6.66 LTS
    ./hardware.nix
  ];

  # Enable TPM
  boot.initrd.availableKernelModules = ["tpm_tis"];

  # Sensors
  hardware.sensor.iio.enable = true;

  # Services
  services = {
    ## Driver updates
    fwupd = {
      enable = true;
      extraRemotes = ["lvfs-testing"]; # See https://github.com/NixOS/nixos-hardware/tree/master/framework
    };

    ## Lid switch
    logind = {
      lidSwitchExternalPower = "ignore";
    };
  };
}
