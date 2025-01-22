# Home manager module that configures Pinta
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    pinta
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/Pinta"
    ];
  };
}
