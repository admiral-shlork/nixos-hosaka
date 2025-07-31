{ config, pkgs, ... }:

let
  codiumWrapped = pkgs.writeShellScriptBin "codium" ''
    export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
    exec ${pkgs.vscodium}/bin/codium "$@"
  '';
in
{
  environment.systemPackages = with pkgs; [
    codiumWrapped
    # other packages...
  ];

  # Optionally install vscodium itself so icons & data are available system-wide
  environment.systemPackages = with pkgs; [
    pkgs.vscodium
  ] ++ config.environment.systemPackages;
}
