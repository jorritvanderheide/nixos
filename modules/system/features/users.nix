{
  config,
  lib,
  inputs,
  myLib,
  outputs,
  pkgs,
  ...
}: {
  options.mySystem.home-users = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        userConfig = lib.mkOption {
          type = lib.types.path;
          default = ../../../hosts/${config.hostname}/home.nix;
          description = "Path to the user's Home Manager configuration file.";
        };
        userSettings = lib.mkOption {
          type = lib.types.attrs;
          default = {};
          description = "Additional user-specific settings.";
        };
      };
    });
    default = {};
    description = "Configuration for home users.";
  };

  config = {
    programs.fish.enable = true;

    home-manager = {
      backupFileExtension = "backup";

      extraSpecialArgs = {
        inherit inputs;
        inherit myLib;
        outputs = inputs.self.outputs;
      };

      users =
        builtins.mapAttrs (name: user: {...}: {
          imports = [
            (import user.userConfig)
            outputs.homeManagerModules.default
          ];
        })
        (config.mySystem.home-users);
    };

    users.users = builtins.mapAttrs (
      name: user:
        {
          isNormalUser = true;
          extraGroups = ["libvirtd" "networkmanager" "wheel"];
          shell = pkgs.fish;
        }
        // user.userSettings
    ) (config.mySystem.home-users);
  };
}