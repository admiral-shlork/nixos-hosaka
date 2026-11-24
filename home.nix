{ config, lib, pkgs, osConfig, ... }:

let
  hostName = osConfig.networking.hostName;
in

{
  imports = [ ./home/starship.nix ] ++ lib.optionals (hostName == "hosaka") [ ./home/hosaka.nix ];

  # Home Manager configuration options go here
  home = {
    username = "whatever";
    homeDirectory = "/home/whatever";
    stateVersion = "25.05";
    packages = with pkgs; [ ];
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      alias ll='ls -alhF'
      alias la='ls -A'
      alias l='ls -CF'
    '';
  };
}
