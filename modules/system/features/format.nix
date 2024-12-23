{
  inputs,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    alejandra
    home-manager
    nixd
  ];

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
