# Home manager module that configures Discord
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    discord
    vesktop
  ];

  xdg.configFile."vesktop/themes/modular.theme.css".text = ''
    @import url("https://github.com/SEELE1306/Modular/blob/release/modular.theme.css")
  '';

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/vesktop/sessionData"
      ".config/vesktop/settings"
    ];
  };
}
