{ config, pkgs, lib, modulesPath, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    spiceUSBRedirection = {
      enable = true;
    };
    docker = {
      enable = true;
      daemon.settings = {
        "insecure-registries" = ["harbor.micro-slab:88"];
      };
    };
    waydroid = {
      enable = true;
    };
  };
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["root" "whatever" ];
}