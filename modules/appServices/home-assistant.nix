{
  lib,
  config,
  ...
}:
{
  options = {
    home-assistant.enable = lib.mkEnableOption "enables Home Assistant Smart Home Suite";
  };

  config = lib.mkIf config.home-assistant.enable {
    services.home-assistant = {
      enable = true;
      config = null;
      configDir = "/etc/home-assistant";
    };
  };
}
