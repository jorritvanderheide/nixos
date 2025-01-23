# Home manager module that configures Signal
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    signal-desktop
  ];

  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/Signal"
    ];
  };
}
