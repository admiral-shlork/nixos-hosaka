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
    stateVersion = "25.05";
    packages = with pkgs; [
      antigravity-fhs
      # audacity
      brave
      calibre
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
      aisleriot
      alpaca
      alsa-utils
      chatbox
      cheese
      # chromium
      discord
      docker
      dropbox
      element-desktop
      firefox-devedition
      floorp-bin
      fooyin
      gimp
      gnome-mahjongg
      # godotPackages_4_5.godot
      hamster
      ibm-plex
      jdk
      #jetbrains.pycharm-community
      keepassxc
      libreoffice
      librewolf
      lutris
      mangohud
      # megasync
      mono
      moonlight-qt
      nicotine-plus
      pandoc
      piper-tts
      protonvpn-gui
      python3
      python311Packages.pip
      remmina
      signal-desktop
      soundconverter
      telegram-desktop
      textpieces
      thunderbird
      ungoogled-chromium
      veracrypt
      vivaldi
      vlc
      vscodium-fhs
      waydroid
      waydroid-helper
      winbox4
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
  programs.rclone.enable = true;
  # programs.chromium.enable = true;
  xdg.enable = true;
}

