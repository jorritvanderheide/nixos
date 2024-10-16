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
      specialArgs = {
        inherit inputs outputs;
        crossSystem = {
          hostPlatform = inputs.nixpkgs.lib.systems.platforms.x86_64-linux; # Set host platform here
        };
      };
      modules = [
        ../../hosts/common
        config
      ];
    };

  # mkHome = config:
  #   inputs.home-manager.lib.homeManagerConfiguration {
  #     pkgs = pkgsFor sys;
  #     extraSpecialArgs = {
  #       inherit inputs outputs;
  #     };
  #     modules = [
  #       config
  #     ];
  #   };
}
