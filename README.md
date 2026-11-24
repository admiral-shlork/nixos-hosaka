# New system installation

## Prerequisites

See `fileSystems` config for the host and create necessary partitions. For existing partitions, make sure to update `fileSystems` to reflect how storage is set up.


## Installation

1. Boot NixOS from a Live USB

2. Enter shell with git and vscodium:

```bash
nix --extra-experimental-features "nix-command flakes" shell nixpkgs#git nixpkgs#vscodium
```

3. Mount all required partitions under `/mnt`.

- On new hardware, consider running `nixos-generate-config` and examine the `hosts/hosaka/configuration.nix` and `hardware.nix` to see if any declarations are required to be added to the configuration.

4. Clone the repo with the configuration:

```bash
git clone git@github.com:admiral-shlork/nixos-hosaka.git
```
```bash
git clone https://github.com/admiral-shlork/nixos-hosaka.git
```

5. To install the OS run the following command from the root folder of the cloned repository:

```bash
sudo nixos-install --root /mnt --flake .#hosaka
```

6. Set a password for the user:

```bash
nixos-enter --root /mnt -c 'passwd whatever'
```

## Some useful Nix commands:

All commands are run from the root folder of the cloned repository.

**Switch** - apply the configuration and activate it immediately on the running system.

```bash
sudo nixos-rebuild switch --flake .#hosaka
```

**Boot** - build the configuration and make it the default boot entry, applying it after the next reboot.

```bash
sudo nixos-rebuild boot --flake .#hosaka
```

**Clean** - remove older generations from the bootloader. Use either of:

```bash
nix-collect-garbage --delete-older-than 1d
```
```bash
nh clean all --keep 2
```

**Update** - update the `flake.lock` file:

```bash
nix flake update
```

### Usage

- Apply the configuration now: run **Switch**.
- Build the configuration and apply it on the next reboot: run **Boot**.
- Remove older generations from the bootloader: run **Clean**, then apply the configuration with **Boot**.
- Update the `flake.lock` file and rebuild the system: run **Update**, then apply the configuration with **Switch**.

# Appendix

## Partitioning cheat sheet

- create and open a LUKS container
```bash
cryptsetup luksFormat /dev/sda1
```
```bash
cryptsetup luksOpen /dev/sda1 some_luks_container
```

- create an LVM Physical Volume and add a Volume Group to it
```bash
pvcreate /dev/mapper/some_luks_container
```
```bash
vgcreate some_volume_group /dev/mapper/some_luks_container
```

- create LVM Logical Volume
```bash
lvcreate -n some_logical_volume -L 42G some_volume_group
```
```bash
lvcreate -n some_logical_volume -l 100%FREE some_volume_group
```

- create a filesystem
```bash
mkfs.ext4 /dev/mapper/some_logical_volume
```
```bash
mkfs.vfat /dev/mapper/some_partition
```

- set a partition label
```bash
e2label /dev/mapper/some_logical_volume some_label
```
```bash
fatlabel /dev/sda1 some_label
```

## Assorted useful commands

- create a key file and attach it to a LUKS container
```bash
dd if=/dev/urandom of=/root/some_luks_container.key bs=1024 count=4
```
```bash
chmod 0400 /root/some_luks_container.key
```
```bash
cryptsetup luksAddKey /dev/sda1 /root/some_luks_container.key
```
