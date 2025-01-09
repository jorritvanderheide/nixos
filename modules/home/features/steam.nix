# Home manager module that configures Steam
{
  config,
  lib,
  ...
}: {
  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".local/share/steam"
    ];
  };
}
