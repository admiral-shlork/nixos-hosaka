{ config, pkgs, modulesPath, ... }:

{
boot = {
  # Bootloader
  initrd.availableKernelModules = [ "ahci" "ata_piix" "ohci_pci" "ehci_pci" "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
  initrd.kernelModules = [ "dm-snapshot" ];
  kernelModules = [ "kvm-amd" "8821ce" ];
  kernelPackages = pkgs.linuxPackages_latest;
  kernelParams = [ "usbocre.autosuspend=-1" "amdgpu.reset=1"];
  extraModulePackages = [ ];
  loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  initrd.luks.devices = let
    luks_root_uuid = "5180ba8f-582c-4108-8886-34453b167370";
  in {
    # LUKS container with root partition
    "luks-${luks_root_uuid}" = {
      device = "/dev/disk/by-uuid/${luks_root_uuid}";
      allowDiscards = true;
    };
  };
};

  swapDevices = [{ 
      #device = "/dev/disk/by-label/root";
      device = "/swapfile";
      size = 64 * 1024;
    }];

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
