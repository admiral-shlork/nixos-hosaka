{ config, pkgs, lib, modulesPath, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      allowedBridges = [ "virbr0" ];
      extraConfig = ''
        firewall_backend = "nftables"
      '';
      qemu.verbatimConfig = ''
        nvram = ["/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd"]
        virtiofsd_path = "/run/current-system/sw/bin/virtiofsd"
      '';
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
  environment.sessionVariables = {
    LIBVIRT_DEFAULT_URI = "qemu:///system";
  };
}