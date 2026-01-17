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
    };
    waydroid = {
      enable = true;
    };
  };
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["root" "whatever" ];
}