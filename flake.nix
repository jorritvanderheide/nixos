{
  inputs = {
    # Official sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Community sources
    disko.url = "github:nix-community/disko"; # Disk management
    impermanence.url = "github:nix-community/impermanence"; # Ephemeral system configs

    ## User environment management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Bootloader management
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: let
    myLib = import ./lib/myLib {inherit inputs;}; # Load custom utility library
  in {
    # System configurations
    nixosConfigurations = {
      framework = myLib.mkSystem "x86_64-linux" ./hosts/framework;
    };

    # Home configurations
    homeConfigurations = {
      "jorrit@framework" = myLib.mkHome "x86_64-linux" ./hosts/framework/users/jorrit.nix;
    };

    nixosModules.default = ./modules/system; # System modules
    homeManagerModules.default = ./modules/home; # Home module
  };
}
