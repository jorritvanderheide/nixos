#  _
# (_)_ __ ___  _ __   ___ _ __ _ __ ___   __ _ _ __   ___ _ __   ___ ___
# | | '_ ` _ \| '_ \ / _ \ '__| '_ ` _ \ / _` | '_ \ / _ \ '_ \ / __/ _ \
# | | | | | | | |_) |  __/ |  | | | | | | (_| | | | |  __/ | | | (_|  __/
# |_|_| |_| |_| .__/ \___|_|  |_| |_| |_|\__,_|_| |_|\___|_| |_|\___\___|
#             |_|
#
# System configuration for impermanence.
{
  config,
  lib,
  ...
}: {
  # Configure boot
  fileSystems."/persist".neededForBoot = true;

  # Setup persistence directories
  environment.persistence."/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/nixos"
      "/etc/wireguard"
      "/etc/ssh"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/log"
    ];
    files = [
      "/etc/machine-id"
      "/var/lib/alsa/asound.state"
      "/var/lib/cups/printers.conf"
    ];
  };

  # Configure sudo
  security.sudo.wheelNeedsPassword = false;

  # Wipe root on boot
  boot.initrd.postDeviceCommands = lib.mkAfter ''
    mkdir /btrfs_tmp
    mount /dev/root_vg/root /btrfs_tmp
    if [[ -e /btrfs_tmp/root ]]; then
        mkdir -p /btrfs_tmp/old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
    fi

    delete_subvolume_recursively() {
        IFS=$'\n'
        for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
            delete_subvolume_recursively "/btrfs_tmp/$i"
        done
        btrfs subvolume delete "$1"
    }

    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
    done

    btrfs subvolume create /btrfs_tmp/root
    umount /btrfs_tmp
  '';
}
