{ pkgs, lib, ... }:
{

  imports = [
    ./plasmaManager.nix
  ];

  plasmaManager.enable = lib.mkDefault false;
}
