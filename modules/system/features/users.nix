# TODO: cleanup
{
  config,
  lib,
  ...
}: {
  options.mySystem.home-users = lib.mkOption {
    type = lib.types.attrsOf (lib.types.submodule {
      options = {
        userConfig = lib.mkOption {
          type = lib.types.path;
          default = ../../../hosts/${config.hostname}/users/jorrit.nix; # TODO: make dynamic
          description = "path to the user's home configuration.";
        };
        userSettings = lib.mkOption {
          type = lib.types.attrs;
          default = {};
          description = "additional user-specific settings.";
        };
      };
    });
    default = {};
    description = "configuration for home users.";
  };

  config = {
    users.users = builtins.mapAttrs (
      name: user:
        {
          isNormalUser = true;
          extraGroups = ["libvirtd" "networkmanager" "wheel"];
        }
        // user.userSettings
    ) (config.mySystem.home-users);
  };
}
