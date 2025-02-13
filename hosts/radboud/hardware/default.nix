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

  # Swapfile
  swapDevices = [ {
    device = "/dev/zvol/zroot/swap";
  } ];
}
