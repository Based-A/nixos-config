{
  lib,
  config,
  ...
}:
{
  options = {
    bluetooth.enable = lib.mkEnableOption "enables bluetooth";
  };

  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    hardware.bluetooth.settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };

    services.blueman.enable = true;
  };
}
