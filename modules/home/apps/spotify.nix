# Home manager module that configures Spotify
{
  config,
  inputs,
  lib,
  ...
}: let
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify.enable = true;

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/spotify"
    ];
  };
}
