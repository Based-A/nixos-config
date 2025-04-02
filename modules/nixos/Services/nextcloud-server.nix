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
        adminuser = "Adam L";
      };
      settings = {
        trusted_domains = [
          "192.168.50.143"
        ];
      };
    };

    networking.firewall.allowedTCPPorts = [ 80 443 ];

    /* TODO:
    Figure out S3 integration.
    See if there's any other nextcloud apps that I want to install.
    */
    #Reference: https://wiki.nixos.org/w/index.php?title=Nextcloud
  };
}