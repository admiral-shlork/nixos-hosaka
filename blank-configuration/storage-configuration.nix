{ config, pkgs, modulesPath, ... }:

{
boot = {
  # Bootloader
  initrd.availableKernelModules = [ "ahci" "ata_piix" "ohci_pci" "ehci_pci" "xhci_pci" "nvme" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  initrd.kernelModules = [ "dm-snapshot" ];
  kernelModules = [ "kvm-amd" "8821ce" ];
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

  # swapDevices = [{ 
  #     device = "/dev/disk/by-uuid/c30a3550-ab3b-4820-afc7-b833f4f3b36c";
  #     device = "/swapfile";
  #     size = 64 * 1024;
  #   }];

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
  
  fileSystems."/" =
    { device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-label/home";
      fsType = "ext4";
    };
}
