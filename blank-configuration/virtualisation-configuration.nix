{ config, pkgs, lib, modulesPath, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      allowedBridges = [ "virbr0" ];
      extraConfig = ''
        firewall_backend = "nftables"
      '';
      qemu = {
        runAsRoot = true;
        swtpm.enable = false;
      };
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
  environment.etc."libvirt/qemu.conf".text = ''
  virtiofsd_path = "/run/current-system/sw/bin/virtiofsd"
'';
}