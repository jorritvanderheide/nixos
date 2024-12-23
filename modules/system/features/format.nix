{
  inputs,
  pkgs,
  ...
}: {
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  environment.systemPackages = with pkgs; [
    alejandra
    nixd
  ];
}
