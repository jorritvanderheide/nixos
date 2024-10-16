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
}
