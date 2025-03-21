# Home manager module that configures DBeaver
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    dbeaver-bin
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/dbeaver"
    ];
  };
}
