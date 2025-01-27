{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  options = {
    plex.enable = lib.mkEnableOption "enables plex media server";
  };

  config = lib.mkIf config.plex.enable {
    services.plex = {
      enable = true;
      openFirewall = true;
      user = "plex";
      group = "plex";
    };

    networking.firewall.allowedTCPPorts = [ 32400 ];
  };
  #	Relevant Nix Wiki: https://wiki.nixos.org/wiki/Plex
}
