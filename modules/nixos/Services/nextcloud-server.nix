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
        dbtype = "sqlite";
        adminpassFile = "/etc/nextcloud-admin-pass";
      };
      
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];

    environment.etc."nextcloud-admin-pass".text = "adminPass!";

    #Reference: https://wiki.nixos.org/w/index.php?title=Nextcloud
  };
}