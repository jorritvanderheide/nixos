# Home manager module that configures sops-nix
{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = ".config/sops/age/keys.txt";
    defaultSopsFile = ../../../users/jorrit/secrets.yaml;
  };

  # Conditionally persist directories
  myHome = lib.mkIf config.myHome.impermanence.enable {
    impermanence.directories = [
      ".config/sops/age"
    ];
  };
}
