# Home manager module that configures Steam
{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    protonup
  ];

  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\\\${HOME}/.steam/root/compatibilitytools.d";
  };

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence = {
      directories = [
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
        ".steam/root/compatibilitytools.d"
      ];
    };
  };
}
