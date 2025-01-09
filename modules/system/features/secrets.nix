# System module that configures secrets management using nix-sops
{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = with pkgs; [
    age
    sops
  ];

 
   sops = {
    age.keyFile = "/var/lib/sops-nix/keys.txt";
    defaultSopsFile = ../../../hosts/secrets.yaml;
    secrets.jorrit_login.neededForUsers = true;
  };

  # Conditional persist
  mySystem = lib.mkIf config.mySystem.impermanence.enable {
    impermanence.directories = [
      "/etc/ssh"
      "/var/lib/sops-nix"
    ];
  };
}
