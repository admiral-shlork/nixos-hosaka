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

  # Define the systemd service
  systemd.services.virtiofsd-vmshare = {
    description = "virtiofsd shared folder for Windows VM";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      ExecStart = ''
        ${pkgs.virtiofsd}/bin/virtiofsd \
          --socket-path=/run/virtiofsd-vmshare.sock \
          --shared-dir=/home/whatever/Things/windows_share \
          --cache=auto
      '';
      Restart = "on-failure";

      # virtiofsd needs to run as root or with sufficient caps
      # to access the socket path under /run
      User = "root";
    };
  };
}