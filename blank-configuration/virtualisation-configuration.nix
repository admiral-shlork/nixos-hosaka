{ config, pkgs, lib, modulesPath, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      allowedBridges = [ "virbr0" ];
    };
    spiceUSBRedirection = {
      enable = true;
    };
    docker = {
      enable = true;
      daemon.settings = {
        "insecure-registries" = ["registry.futro"];
      };
    };
    waydroid = {
      enable = true;
    };
  };
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["root" "whatever" ];
}