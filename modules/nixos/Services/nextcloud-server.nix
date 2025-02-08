{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    nextcloud-server.enable = lib.mkEnableOption "enables the Nextcloud self-hosted storage platform";
  };

  config = lib.mkIf config.nextcloud-server.enable {
    services.nextcloud = {
      enable = true;
      hostName = "localhost";
      config = {
        adminpassFile = "/run/secrets/nextcloudPassword";
      };
      secretFile = "/run/secrets/nextcloudPassword";
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];

    #Reference: https://wiki.nixos.org/w/index.php?title=Nextcloud
  };
}