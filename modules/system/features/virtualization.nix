# System module that configures virtualization and Docker
{pkgs, ...}: {
  # Virtualization
  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "zfs";

  # Docker
  environment.systemPackages = with pkgs; [
    docker
  ];
}
