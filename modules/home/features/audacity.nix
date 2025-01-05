# Home manager module that configures Audacity
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    audacity
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/audacity"
    ];
  };
}
