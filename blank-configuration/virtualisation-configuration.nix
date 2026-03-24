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
        "insecure-registries" = ["registry.gitlab.futro:88" "registry.gitlab.futro"];
      };
    };
    waydroid = {
      enable = true;
    };
  };
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["root" "whatever" ];
}