# Home manager module that configures Firefox
{
  config,
  lib,
  ...
}: {
  programs = {
    firefox.enable = true;
  };

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".mozilla"
    ];
  };
}
