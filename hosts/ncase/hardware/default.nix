# Hardware configuration for Framework
{
  config,
  lib,
  pkgs,
  ...
}: {
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

    # Sensors
    sensor.iio.enable = true;
  };

  # Services
  services = {
    ## Nvidia drivers
    xserver.videoDrivers = ["nvidia"];
  };

  # Sensors
  environment.systemPackages = with pkgs; [
    fan2go
    lm_sensors
  ];

  # Conditionally persist directories
  mySystem = lib.mkIf config.mySystem.impermanence.enable {
    impermanence.files = [
      "/etc/fan2go/fan2go.yaml"
    ];
  };
}
