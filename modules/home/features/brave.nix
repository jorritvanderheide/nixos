# Home manager module that configures Brave browser
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    brave
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/BraveSoftware/Brave-Browser"
    ];
  };
}
