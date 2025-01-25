# Jorrit's NixOS Configuration

## Overview

This repository contains a modular NixOS and Home Manager configuration. Some key features include:

- **Modular setup**: You can easily enable or disable features based on your needs.
- **LUKS disk management**: Managed using Disko, with options for encryption and impermanence.
- **Secure Boot**: Managed using Lanzaboote, with the option to auto-decrypt LUKS volumes via the TPM (Trusted Platform Module).

## Installation Steps

Follow these steps to install and configure the system:

1. **Make a new host**: Create a new host for your system by copying one of the pre-existing host folders. It is convenient to do this on another machine and push it to Git. Make sure you disable secureboot In `hosts/<hostname>/default.nix` for the initial installation. You can re-enable it after the first boot.

2. **Configure the disk**: Define the disk for installation in the disk module section of `hosts/<hostname>/default.nix` (ex. `nvme0n1`).

3. **Create encryption key**: Generate a disk encryption password and store it in `/tmp/secret.key`.

   ```shell
   nano /tmp/secret.key
   ```

4. **Install OS**: With the previous steps completed, run the following command to partition the disk and install the operating system:

   ```shell
   sudo nix --extra-experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' -- --flake github:jorritvanderheide/nixos#<hostname> --disk main /dev/<disk>
   ```

5. **Setting up the home directory**: If using impermanence, reboot into the new system and make a new user directory in the persistent folder with your user as the owner:

   ```shell
   mkdir -p /persist/home/<username>
   sudo chown <username>:users /persist/home/<username>
   ```

6. **Running Home Manager**: If Home Manager has not ran and you don't have access to user apps on your new system, you can run it manually:

   ```shell
   home-manager switch --flake /etc/nixos#<username>@<hostname>
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
>
> 2. Check if the keys were put in `/var/lib/sbctl`. If not, run:
>
>    ```shell
>    sbctl setup --migrate
>    ```
> 3. Rebuild your system with the secure-boot module enabled.
>
> 4. Reboot into UEFI and enable secure boot. If possible, enter the secure boot setup mode and reboot into your system.
>
> 5. Enroll your keys:
>
>    ```shell
>    sudo sbctl enroll-keys --microsoft
>    ```
>
>    You can now reboot and secure boot should be enabled.

## TPM-Based LUKS decryption

If you prefer a streamlined boot process and are willing to trade some security for convenience, you can configure your system to automatically decrypt the LUKS volume using the TPM.

To enable this feature, enroll your credentials with the following command:

```shell
sudo systemd-cryptenroll --wipe-slot=tpm2 /dev/<encrypted-disk-partition> --tpm2-device=auto --tpm2-pcrs=0+2+7
```

This will prompt you for a password, which should match with the password you entered in `/tmp/secret.key`.
