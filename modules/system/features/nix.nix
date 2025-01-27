# System module that configures the Nixd language server and Alejandra formatter
{
  inputs,
  pkgs,
  ...
}: {
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  environment.systemPackages = with pkgs; [
    alejandra
    nixd
    nixpkgs-fmt
  ];
}
