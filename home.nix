{ config, pkgs, lib, ... }:


let
  vscodiumWrapped = pkgs.writeShellScriptBin "codium" ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
    exec ${pkgs.vscodium}/bin/codium "$@"
  '';
in

{
  imports =
    [
      ./home-configuration/gnome-configuration.nix
      ./home-configuration/starship-configuration.nix
    ];

  # Home Manager configuration options go here
  home = {
    username = "whatever";
    homeDirectory = "/home/whatever";
    stateVersion = "25.05";
    packages = with pkgs; [
      # audacity
      # calibre
      # deadbeef-with-plugins
      # deluge-gtk
      # easytag
      # nerdfonts
      # parsec-bin
      # soulseekqt
      # soundconverter
      # steam
      # yacreader
      #pkgs.vscodium
      #vscode
      aider-chat-full
      alpaca
      cheese
      code-cursor
      discord
      docker
      dropbox
      element-desktop
      evince
      firefox-devedition
      floorp
      gimp
      gnome-screenshot
      ibm-plex
      jdk
      jetbrains.pycharm-community
      keepassxc
      libreoffice
      librewolf
      lutris
      mangohud
      megasync
      mono
      moonlight-qt
      obsidian
      pkgs.stdenv.cc.cc  # Ensure runtime C++ libs are available
      protonvpn-gui
      python3
      python311Packages.pip
      signal-desktop
      telegram-desktop
      thunderbird
      ungoogled-chromium
      veracrypt
      vivaldi
      vlc
      vscodiumWrapped
      winbox
      wine
      winetricks
      xdg-utils
    ];
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
