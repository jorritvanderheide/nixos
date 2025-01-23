# System module that imports and enables all system modules
{
  config,
  lib,
  myLib,
  ...
}: let
  cfg = config.mySystem;

  # Recursively enable all system modules
  nixos-modules =
    myLib.extendModules
    (name: {
      extraOptions = {
        mySystem.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };
      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./.);
in {
  imports = nixos-modules;
}
