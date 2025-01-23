# Home manager module that configures VLC
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    vlc
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/vlc"
    ];
  };
}
