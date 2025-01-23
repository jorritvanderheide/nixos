# Home manager module that imports and enables all home manager modules
{
  config,
  lib,
  myLib,
  ...
}: let
  cfg = config.myHome;

  # Recursively enable all home-manager modules
  home-modules =
    myLib.extendModules
    (name: {
      extraOptions = {
        myHome.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };
      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./.);
in {
  imports = home-modules;
}
