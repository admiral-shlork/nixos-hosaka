{
  description = "whatever Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    { self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      nixos-hardware,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgsUnstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      mkNixosConfiguration = hostPath: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit pkgsUnstable nixos-hardware; };
        modules = [
          hostPath
          home-manager.nixosModules.home-manager
          {
            _module.args.inputs = self.inputs;
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        hosaka = mkNixosConfiguration ./hosts/hosaka/configuration.nix;
      };
    };
}
