{
  pkgs,
  lib,
  config,
  inputs,
  host,
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
        adminpassFile = "/home/${host}/.config/nextcloud.txt";
        adminuser = "root";
      };
      settings = {
        trusted_domains = [
          "192.168.50.143"
        ];
      };
      #secretFile = "/home/${host}/.config/nextcloud.txt";
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];

    /*users = {
      users.nextcloud = {
        name = "nextcloud";
        uid = 2001;
        group = "nextcloud";
      };
      groups.nextcloud = {};
    };*/

    #Reference: https://wiki.nixos.org/w/index.php?title=Nextcloud
  };
}