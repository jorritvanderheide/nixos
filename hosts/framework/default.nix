#   __                                             _
#  / _|_ __ __ _ _ __ ___   _____      _____  _ __| | __
# | |_| '__/ _` | '_ ` _ \ / _ \ \ /\ / / _ \| '__| |/ /
# |  _| | | (_| | | | | | |  __/\ V  V / (_) | |  |   <
# |_| |_|  \__,_|_| |_| |_|\___| \_/\_/ \___/|_|  |_|\_\
#
#
# Host configuration for framework.
{
  config,
  inputs,
  pkgs,
  ...
}: let
  diskoConfig = import ./disko.nix {device = "/dev/nvme0n1";};
in {
  imports = [
    diskoConfig
    inputs.disko.nixosModules.default
    inputs.nixos-hardware.nixosModules.framework-13th-gen-intel

    ../../modules/nixos/power

    ./hardware-configuration.nix
  ];

  # Boot
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
      };
      systemd-boot.enable = false;
    };
  };

  # Networking
  networking = {
    hostName = "framework";
  };

  # Framework-specific services for fingerprint support
  services = {
    fprintd.enable = true;
    fwupd.enable = true;
    fwupd.package =
      (import (builtins.fetchTarball {
          url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
          sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
        }) {
          inherit (pkgs) system;
        })
      .fwupd;
  };
}
