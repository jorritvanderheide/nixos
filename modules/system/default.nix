{
  config,
  inputs,
  lib,
  myLib,
  ...
}: let
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
  imports =
    [
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ features;

  # Networking
  networking.hostName = "framework";
  networking.networkmanager.enable = true;

  # Nix
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["flakes" "nix-command"];
      warn-dirty = false;
    };
    extraOptions = ''
      trusted-users = root jorrit
    ''; # TODO: make modular
  };

  # Nixpkgs
  nixpkgs.config.allowUnfree = true;

  # Time
  time.timeZone = "Europe/Amsterdam";
}
