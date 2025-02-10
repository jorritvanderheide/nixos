# Home manager module that configures EduVPN
{config, lib, pkgs, ...}: with lib; {
  home.packages = with pkgs; [
    eduvpn-client
  ];

  # Conditionally persist directories
  myHome = mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/eduvpn"
    ];
  };
}
