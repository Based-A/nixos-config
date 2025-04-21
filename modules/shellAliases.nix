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
        # System Updates
        configRebuild = "sudo nixos-rebuild switch --flake .#${host}";
        Update = "nix flake update";
        homeRebuild = "home-manager switch --flake .#Adam";

        # Dev Shells
        bevyDev = "nix shell /home/flake/modules/nixShells/bevyShell.nix";
        godotDev = "nix shell /home/flake/modules/nixshells/godotShell.nix";
        unrealDev = "nix shell /home/flake/modules/nixshells/unrealShell.nix";
      };
    };
  };
}