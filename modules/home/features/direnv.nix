# Home manager module that configures Direnv
{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };

  # Devenv
  home.packages = with pkgs; [
    devenv
  ];

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".local/share/direnv"
    ];
  };
}
