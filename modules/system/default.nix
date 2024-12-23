{
  config,
  inputs,
  lib,
  myLib,
  pkgs,
  ...
}:
let
  cfg = config.mySystem;
  
  # Enable features
  features =
    myLib.extendModules
    (name: {
      extraOptions = {
        mySystem.${name}.enable = lib.mkEnableOption "enable my ${name} configuration";
      };
      configExtension = config: (lib.mkIf cfg.${name}.enable config);
    })
    (myLib.filesIn ./features);
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ]
  ++ features;

  # Networking
  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  # Nix
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["flakes" "nix-command"];
    warn-dirty = false;
  };

  # Nixpkgs
  nixpkgs.config.allowUnfree = true;

  # Time
  time.timeZone = "Europe/Amsterdam";

  # System packages
  environment.systemPackages = with pkgs; [
    alejandra
    home-manager
    nixd
  ];
}