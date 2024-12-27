# Home manager module that imports and enables all home manager modules
{
  config,
  lib,
  myLib,
  ...
}: let
  cfg = config.myHome;

  # Enable all modules in ./features
  features =
    myLib.extendModules
    (name: {
      extraOptions = {
        myHome.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };
      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./features);
in {
  imports = features;
}
