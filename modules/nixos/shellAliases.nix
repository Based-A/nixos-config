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
        configRebuild = "cd /home/flake | sudo nixos-rebuild switch --flake .#${host}";
        Update = "cd /home/flake | nix flake update";
        homeRebuild = "home-manager switch --flake .#Adam";
        houdini = "nix run github:pedohorse/houdini-nix#sesinetd-20_5_445 -- /home/adam/houdini-20_5/hlicenses --user adam --group adam | ./home/adam/houdini-20_5/result/bin/houdini";
      };
    };
  };
}