# Help is available in the configuration.nix(5) man page and 
# in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  programs.firefox.enable = true;
  programs.direnv.enable = true;

  # Define your user-specific home configuration
  users.users.whatever = {
    isNormalUser = true;
    home = "/home/whatever";
    # Add more configurations for your user here
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    appimage-run
    brlaser
    git
    dconf-editor
    ghostty
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-panel
    gnomeExtensions.date-menu-formatter
    gnomeExtensions.night-theme-switcher
    gnomeExtensions.no-overview
    home-manager
    nh
    terminator
    vim
    vscodium
    wget
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Minimal gnome installation
  environment.gnome.excludePackages =
    (with pkgs; [
      atomix
      cheese
      epiphany
      evince
      geary
      gedit
      gnome-calendar
      gnome-characters
      gnome-connections
      gnome-console
      gnome-contacts
      gnome-maps
      gnome-music
      gnome-photos
      gnome-software
      gnome-terminal
      gnome-tour
      gnome-weather
      hitori
      iagno
      simple-scan
      snapshot
      tali
      totem
      yelp
    ]);

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
