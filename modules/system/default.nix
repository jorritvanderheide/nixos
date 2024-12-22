{
  config,
  inputs,
  lib,
  myLib,
  ...
}:
let
  cfg = config.mySystem;
  
  # Taking all modules in ./features and adding enables to them
  features =
    myLib.extendModules
    (name: {
      extraOptions = {
        mySystem.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };
      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./features);

    # # Taking all module bundles in ./bundles and adding bundle.enables to them
    # bundles =
    #   myLib.extendModules
    #   (name: {
    #     extraOptions = {
    #       mySystem.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
    #     };
    #     configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
    #   })
    #   (myLib.filesIn ./bundles);
in {
  imports = [
    inputs.disko.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
  ]
  ++ features;
  # ++ bundles;

  # Networking
  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  # Time
  time.timeZone = "Europe/Amsterdam";
}