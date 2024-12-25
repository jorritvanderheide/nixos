{
  config,
  lib,
  myLib,
  ...
}: let
  cfg = config.mySystem;

  # Enable all modules in ./features
  features =
    myLib.extendModules
    (name: {
      extraOptions = {
        mySystem.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };
      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./features);
in {
  imports = features;
}
