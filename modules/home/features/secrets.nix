# Home manager module that configures sops-nix
{
  config,
  lib,
  ...
}: {
  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/sops/age"
    ];
  };
}
