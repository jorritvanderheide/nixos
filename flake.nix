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

    # Community inputs
    agenix.url = "github:ryantm/agenix";
    disko.url = "github:nix-community/disko";
    home-manager.url = "github:nix-community/home-manager";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = {...} @ inputs: let
    overlays = import ./overlays {inherit inputs;};
    utils = import ./lib/utils {inherit inputs overlays;};
  in
    with utils; {
      # Hosts
      nixosConfigurations = {
        # Hostname
        hostname = mkSystem ./hosts/hostname;
      };

      # Users
      homeManagerConfigurations = {
        # Username
        username = mkHome ./users/username;
      };
    };
}
