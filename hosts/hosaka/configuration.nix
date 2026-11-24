{ nixos-hardware, ... }:

#
# Lenovo ThinkPad T14s Gen 4 (AMD)
# AMD Ryzen 7 PRO 7840U (8 cores / 16 threads)
# 32GB RAM
# 4TB NVMe SSD
#

{
  imports =
    [
      ../../common/misc.nix
      ../../common/prometheus.nix
      ./hardware.nix
      ./misc.nix
      ./networking.nix
      ./printing.nix
      ./software.nix
      ./storage.nix
      ./virtualisation.nix
      nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen4
    ];
}
