# Home manager module that configures Discord
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    vesktop
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/vesktop/sessionData"
      ".config/vesktop/settings"
    ];
  };
}
