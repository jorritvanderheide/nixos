# Home manager module that configures Mullvad
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    mullvad-vpn
  ];

  # Conditionally persist directories
  # myHome = lib.mkIf config.myHome.impermanence.enable {
  #   impermanence.directories = [
  #     ""
  #   ];
  # };
}
