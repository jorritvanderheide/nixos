# System module that configures virtualization and Docker
{pkgs, ...}: {
  virtualisation.docker = {
    enable = true;
    storageDriver = "zfs";
  };

  # Docker
  environment.systemPackages = with pkgs; [
    docker
  ];
}
