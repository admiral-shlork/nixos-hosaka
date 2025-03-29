{ config, pkgs, modulesPath, ... }:

{
boot = {
  # Bootloader
  initrd.availableKernelModules = [ "ahci" "ata_piix" "ohci_pci" "ehci_pci" "xhci_pci" "nvme" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  initrd.kernelModules = [ "dm-snapshot" ];
  kernelModules = [ "kvm-intel" "iwlwifi" ];
  # kernelPackages = pkgs.linuxPackages_latest;
  extraModulePackages = [ ];
  loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  initrd.luks.devices = let
    luks_root_uuid = "97a00e37-3645-4d26-9377-3b8e1866833e";
  in {
    # LUKS container with root partition
    "luks-${luks_root_uuid}" = {
      device = "/dev/disk/by-uuid/${luks_root_uuid}";
      allowDiscards = true;
    };
  };
};

  # SWAP partition - 927024ce-e001-4f1a-8bd3-15e5474a490b
  swapDevices =
    [ { device = "/dev/disk/by-uuid/927024ce-e001-4f1a-8bd3-15e5474a490b"; }
    ];

  # / partition - 35280608-eb23-474b-837b-98cc9097975f
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/35280608-eb23-474b-837b-98cc9097975f";
      fsType = "ext4";
    };

  # /boot partition - 9DEB-F976
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/9DEB-F976";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  # /home partition - 4010ad96-7dd9-4e5f-8927-540d6f7d4b23
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/4010ad96-7dd9-4e5f-8927-540d6f7d4b23";
      fsType = "ext4";
    };
}
