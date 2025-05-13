{ config, pkgs, lib, ... }:

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
    stateVersion = "24.11";
    packages = with pkgs; [
      # audacity
      # calibre
      # deadbeef-with-plugins
      # deluge-gtk
      discord
      docker
      dropbox
      # easytag
      element-desktop
      evince
      firefox-devedition-bin
      floorp
      gnome-screenshot
      gimp
      jetbrains.pycharm-community
      keepassxc
      libreoffice
      librewolf
      lutris
      mangohud
      megasync
      moonlight-qt
      # nerdfonts
      obsidian
      # parsec-bin
      protonvpn-gui
      python3
      python311Packages.pip
      signal-desktop
      # soulseekqt
      # soundconverter
      # steam
      telegram-desktop
      thunderbird
      ungoogled-chromium
      winbox
      wine
      vivaldi
      veracrypt
      vlc
      # yacreader
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
