#        _   _ _
#  _   _| |_(_) |___
# | | | | __| | / __|
# | |_| | |_| | \__ \
#  \__,_|\__|_|_|___/
#
#
# Utility functions library.
{
  inputs,
  overlays,
  ...
}: let
  outputs = inputs.self.outputs;
  system = "x86_64-linux";
in rec {
  # Package helpers
  pkgs = import inputs.nixpkgs {
    inherit system overlays;
    config.allowUnfree = true;
  };

  # Buildables
  mkSystem = config:
    inputs.nixpkgs.lib.nixosSystem {
      pkgs = pkgs;
      specialArgs = {
        inherit inputs outputs;
      };
      modules = [
        config

        ../../hosts/common
      ];
    };

  mkHome = config:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgs;
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      modules = [
        config

        ../../users/common
      ];
    };
}
