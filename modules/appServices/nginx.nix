{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    nginx-reverse-proxy.enable = lib.mkEnableOption "enables nginx reverse proxy";
  };

  config = lib.mkIf config.nginx-reverse-proxy.enable {
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      virtualHosts = {
        localhost = {
          locations."/".proxyPass = "http://unix:/run/gitlab/gitlab-workhorse.socket";
        };
      };
    };

    services.openssh.enable = true;
  };
}
