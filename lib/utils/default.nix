#        _   _ _
#  _   _| |_(_) |___
# | | | | __| | / __|
# | |_| | |_| | \__ \
#  \__,_|\__|_|_|___/
#
#
# Utility functions for the configuration
{inputs}: let
  outputs = inputs.self.outputs;
in rec {
  # Package helper
  pkgsForAllSystems = pkgs:
    inputs.nixpkgs.lib.genAttrs [
      "x86_64-linux"
      # Add more supported systems
    ]
    (system: pkgs inputs.nixpkgs.legacyPackages.${system});

  # Buildables
  mkSystem = system: config:
    inputs.nixpkgs.lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit inputs outputs;
      };
      modules = [
        ../../hosts/common
        config
      ];
    };

  mkHome = config:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = pkgsForAllSystems."x86_64-linux"; # Defaults to x86_64-linux
      extraSpecialArgs = {
        inherit inputs outputs;
      };
      modules = [
        config
      ];
    };
}
