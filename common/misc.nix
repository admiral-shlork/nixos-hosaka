{ lib, pkgs, ... }:

{
  nixpkgs = {
    hostPlatform = lib.mkDefault "x86_64-linux";
    config.allowUnfree = true;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    download-buffer-size = 524288000;
  };

  time.timeZone = "Europe/Dublin";

  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IE.UTF-8";
      LC_IDENTIFICATION = "en_IE.UTF-8";
      LC_MEASUREMENT = "en_IE.UTF-8";
      LC_MONETARY = "en_IE.UTF-8";
      LC_NAME = "en_IE.UTF-8";
      LC_NUMERIC = "en_IE.UTF-8";
      LC_PAPER = "en_IE.UTF-8";
      LC_TELEPHONE = "en_IE.UTF-8";
      LC_TIME = "en_IE.UTF-8";
    };
  };

  console.keyMap = "pl2";

  users.users.whatever = {
    home = "/home/whatever";
    isNormalUser = true;
    description = "whatever";
    extraGroups = [ "adbusers" "docker" "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  home-manager = {
    users.whatever = import ../home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
