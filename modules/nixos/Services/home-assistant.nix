{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    home-assistant.enable = lib.mkEnableOption "enables Home Assistant Smart Home Suite";
  };

  config = lib.mkIf config.home-assistant.enable {
    services.home-assistant = {
      enable = true;
    };
  };
}
