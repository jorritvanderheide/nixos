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
  pkgs = inputs.nixpkgs.legacyPackages.${system}.extend (self: prev: {
    inherit overlays;
  });

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
      activationPackage = inputs.home-manager.activationPackage;
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      modules = [
        config

        ../../users/common
      ];
    };
}
