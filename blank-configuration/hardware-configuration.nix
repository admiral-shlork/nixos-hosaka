{ config, lib, pkgs, modulesPath, ... }:

{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  hardware = {
    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableAllFirmware = true;
    firmware = [ pkgs.linux-firmware ];
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          UserspaceHID = true;
          ClassicBondedOnly = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };

  services.blueman.enable = true;

  services.hardware.bolt.enable = false;

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
}
