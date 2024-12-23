{pkgs, ...}: {
  programs.fish.enable = true;

  users.users.jorrit.shell = pkgs.fish; # TODO: make dynamic
}
