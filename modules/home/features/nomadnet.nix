# Home manager module that configures NomadNet
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    python313Packages.nomadnet
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".nomadnet"
    ];
  };
}
