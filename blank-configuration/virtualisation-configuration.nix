{ config, pkgs, lib, modulesPath, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    docker = {
      enable = true;
    };
    waydroid = {
      enable = true;
    };
  };
  users.groups.libvirtd.members = ["root" "whatever" ];
}