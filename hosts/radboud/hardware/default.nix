# Hardware configuration for Radboud
{ inputs, ...}: {
  imports = [
    inputs.nixos-hardware.nixosModules.hp-elitebook-845g8 # Import community hardware module
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

  # Swapfile
  swapDevices = [ {
    device = "/dev/zvol/zroot/swap";
  } ];
}
