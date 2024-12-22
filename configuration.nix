{ ... }: {
  imports = [
    ./disko.nix
  ];

  config.hosts.disks = {
    enable = true;
    zfs = {
      hostId = "fd6b58";
      encrypt = true;
      disk = "nvme0n1";
      impermanence = true;
    };
  };
}