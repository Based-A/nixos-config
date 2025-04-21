{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{

  options = {
    homepageDashboard.enable = lib.mkEnableOption "enables a homepage dashboard for the system.";
  };

  config = lib.mkIf config.homepageDashboard.enable {
    services.dashboard = {
      enable = true;
    };
  };
}
