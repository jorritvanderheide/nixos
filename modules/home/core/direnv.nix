# Home manager module that configures Direnv
{
  config,
  lib,
  ...
}: {
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".local/share/direnv"
    ];
  };
}
