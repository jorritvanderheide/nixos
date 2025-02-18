# Home manager module that configures qBitTorrent
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    qbittorrent
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      "qBittorrent"
    ];
  };
}
