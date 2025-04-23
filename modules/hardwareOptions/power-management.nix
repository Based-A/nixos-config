{
  lib,
  config,
  ...
}:
{
  options = {
    power-management.enable = lib.mkEnableOption "enables power-management settings";
  };

  config = lib.mkIf config.power-management.enable {
    powerManagement.enable = true;
    powerManagement.powertop.enable = true;
  };
}
