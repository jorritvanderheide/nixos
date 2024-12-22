{
  config,
  lib,
  myLib,
  ...
}: let
  cfg = config.myHome;
  # Taking all modules in ./features and adding enables to them
  features =
    myLib.extendModules
    (name: {
      extraOptions = {
        myHome.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };

      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./features);

  # # Taking all module bundles in ./bundles and adding bundle.enables to them
  # bundles =
  #   myLib.extendModules
  #   (name: {
  #     extraOptions = {
  #       myHome.bundles.${name}.enable = lib.mkEnableOption "enable ${name} module bundle";
  #     };

  #     configExtension = config: (lib.mkIf cfg.bundles.${name}.enable config);
  #   })
  #   (myLib.filesIn ./bundles);
in {
  imports = [
  ]
  ++ features;
  # ++ bundles;

  # Allow unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg: true;

  # State version - do not change this manually
  home.stateVersion = "24.11";
}