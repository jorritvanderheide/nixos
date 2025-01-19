# Jorrit's NixOS Configuration

## Overview

This repository contains a modular NixOS and Home Manager configuration. Some key features include:

- **Modular setup**: You can easily enable or disable features based on your needs.
- **LUKS disk management**: Managed using Disko, with options for encryption and impermanence.
- **Secure Boot**: Managed using Lanzaboote, with the option to auto-decrypt LUKS volumes via the TPM (Trusted Platform Module).

## Installation Steps

Follow these steps to install and configure the system:

1. **Make a new host**: Create a new host for your system by copying one of the pre-existing hosts

2. **Clone the repo**: Clone the repository using https:

   ```shell
   git clone https://github.com/jorritvanderheide/nixos.git
   ```

3. **Disable secure boot**: In the [mySystem configuration](<hosts/framework/default.nix>), disable secure boot for the initial installation. You can re-enable it after the first boot.

4. **Configure the disk**: Define the disk for installation in the disk module section of the [mySystem configuration](<hosts/framework/default.nix>).

5. **Create encryption key**: Generate a disk encryption password and store it in `/tmp/secret.key`.

6. **Install OS**: With the previous steps completed, run the following command to partition the disk and install the operating system:

   ```shell
   sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake <path-to-flake>#framework --disk main </dev/disk-device>
   ```

## Enabling Secure Boot

After the first boot, if you wish to enable Secure Boot, follow the steps in the [Lanzaboote quick-start guide](https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md).

> [!TLDR]- TLDR
> 
> 1. Create the required keys:
>
>    ```shell
>    nix-shell -p sbctl run 'sudo sbctl create-keys'
>    ```

## TPM-Based LUKS Decryption

If you prefer a streamlined boot process and are willing to trade some security for convenience, you can configure your system to automatically decrypt the LUKS volume using the TPM.

To enable this feature, enroll your credentials with the following command:

```shell
sudo systemd-cryptenroll --wipe-slot=tpm2 /dev/<encrypted-disk-partition> --tpm2-device=auto --tpm2-pcrs=0+2+7
```
