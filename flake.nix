#   __ _       _
#  / _| | __ _| | _____
# | |_| |/ _` | |/ / _ \
# |  _| | (_| |   <  __/
# |_| |_|\__,_|_|\_\___|
#
#
# Minimal flake template
{
  description = "Minimal flake template";

  inputs = {
    # Nix inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-hardware.url = "github:nixos/nixos-hardware";

    # Nix Community inputs
    disko.url = "github:nix-community/disko";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {...} @ inputs: let
    utils = import ./lib/utils {inherit inputs;};
  in
    with utils; {
      # Hosts
      nixosConfigurations = {
        # Hostname
        hostname = mkSystem "x86_64-linux" ./hosts/hostname;
      };

      # Users
      homeManagerConfigurations = {
        # Username
        username = mkHome ./users/username;
      };
    };
}
