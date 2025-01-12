# Hardware configuration for Framework
{config, ...}: {
  imports = [
    ./hardware.nix
  ];

  # Enable TPM
  boot.initrd.availableKernelModules = ["tpm_crb"];

  # Hardware
  hardware = {
    ## OpenGL graphics
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    # ## Nvidia drivers
    nvidia = {
      modesetting.enable = true;
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    ## Logitech Bolt
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  # Services
  services = {
    ## Nvidia drivers
    xserver.videoDrivers = ["nvidia"];
  };
}
