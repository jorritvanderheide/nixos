# Hardware configuration for Framework
{...}: {
  imports = [
    ./hardware.nix
  ];

  # Enable TPM
  boot.initrd.availableKernelModules = ["tpm_crb"];

  # Hardware
  hardware = {
    # Logitech Bolt
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
