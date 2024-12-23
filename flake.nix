{
  inputs = {
    # NixOS modules
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Community modules
    disko.url = "github:nix-community/disko";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: let
    myLib = import ./lib/myLib {inherit inputs;};
  in {
    # System configurations
    nixosConfigurations = {
      framework = myLib.mkSystem "x86_64-linux" ./hosts/framework;
    };

    # Home configurations
    homeConfigurations = {
      "jorrit@framework" = myLib.mkHome "x86_64-linux" ./hosts/framework/users/jorrit.nix;
    };

    # Modules
    nixosModules.default = ./modules/system;
    homeManagerModules.default = ./modules/home;
  };
}
