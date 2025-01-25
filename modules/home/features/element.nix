# Home manager module that configures the Element Matrix client
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    element-desktop
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/Element"
    ];
  };
}
