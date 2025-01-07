# Home manager module that configures Brave browser
{
  config,
  lib,
  ...
}: {
  home.packages.steam.enable = true;

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".local/share/Steam"
      ".steam"
    ];
  };
}
