{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  options = {
    sunshine.enable = lib.mkEnableOption "enables sunshine streaming protocol";
  };

  config = lib.mkIf config.sunshine.enable {
    services.sunshine = {
      enable = true;
      autoStart = false;
      openFirewall = true;
      capSysAdmin = true;
    };

    security.wrappers.sunshine = {
      owner = "root";
      group = "root";
      #capabilities = "cap_sys_admin+p";
      source = "${pkgs.sunshine}/bin/sunshine";
    };

    networking.firewall.allowedTCPPorts = [
      47984
      47989
      47990
      48010
    ];
    networking.firewall.allowedUDPPorts = [
      47998
      47999
      48000
      8000
      8001
      8002
      8003
      8004
      8005
      8006
      8007
      8008
      8009
      8010
    ];

    #	Relevant Wiki Link: https://wiki.nixos.org/wiki/Sunshine
  };
}
