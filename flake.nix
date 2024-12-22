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
  };

  outputs = {...}@inputs: {
    nixosConfigurations = {
      framework = inputs.nixpkgs.legacyPackages.x86_64-linux.nixos [
        inputs.disko.nixosModules.disko
        ./configuration.nix
       ];
    };
  };
}