# System module that configures virtualization and Docker
{pkgs, ...}: {
  # Virtualization
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";

  # Docker
  environment.systemPackages = with pkgs; [
    docker
  ];
}
