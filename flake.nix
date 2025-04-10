{
  inputs = {
    # Official sources
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:jorritvanderheide/nixos-hardware";

    # Community sources
    base16.url = "github:SenchoPens/base16.nix"; # Base16 color scheme utility
    disko.url = "github:nix-community/disko"; # Disk management
    home-manager.url = "github:nix-community/home-manager"; # User environment management
    impermanence.url = "github:nix-community/impermanence"; # Ephemeral system configs
    stylix.url = "github:danth/stylix"; # Stylix theme manager

    ## Bootloader management
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Secret managment
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ## Spicetify
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {...} @ inputs: let
    myLib = import ./lib/myLib {inherit inputs;}; # Load custom utility library
  in {
    # System configurations
    nixosConfigurations = {
      ncase = myLib.mkSystem "x86_64-linux" ./hosts/ncase;
      framework = myLib.mkSystem "x86_64-linux" ./hosts/framework;
      radboud = myLib.mkSystem "x86_64-linux" ./hosts/radboud;
    };

    # Home configurations
    homeConfigurations = {
      "jorrit@framework" = myLib.mkHome "x86_64-linux" ./hosts/framework/users/jorrit.nix;
    };

    nixosModules.default = ./modules/system; # System modules
    homeManagerModules.default = ./modules/home; # Home module
  };
}
