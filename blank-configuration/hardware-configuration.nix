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

  services = {
    blueman.enable = true;
    hardware.bolt.enable = false;
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
}
