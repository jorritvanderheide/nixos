{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  inputs.disko.url = "github:nix-community/disko/latest";
  inputs.disko.inputs.nixpkgs.follows = "nixpkgs";

  outputs = { self, disko, nixpkgs }: {
    nixosConfigurations.framework = nixpkgs.legacyPackages.x86_64-linux.nixos [
      disko.nixosModules.disko
      ./configuration.nix
    ];
  };
}