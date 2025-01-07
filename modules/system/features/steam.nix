# Home manager module that configures Steam
{
  config,
  lib,
  ...
}: {
  programs.steam.enable = true;

  # Conditionally persist directories
  mySystem = lib.mkIf config.mySystem.impermanence.enable {
    impermanence.directories = [
      "/home/users/jorrit/.local/share/Steam" # TODO fix for multi-user
    ];
  };
}
