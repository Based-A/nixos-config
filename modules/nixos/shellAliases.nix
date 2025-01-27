{
  pkgs,
  inputs,
  lib,
  config,
  host,
  ...
}:
{
  options = {
    shellAliases.enable = lib.mkEnableOption "adds all of my shell alias commands";
  };

  config = lib.mkIf config.shellAliases.enable {
    programs.bash = {
      shellAliases = {
        configRebuild = "sudo nixos-rebuild switch --flake .#${host}";
        Update = "nix flake update";
        homeRebuild = "home-manager switch --flake .#Adam";
      };
    };
  };
}