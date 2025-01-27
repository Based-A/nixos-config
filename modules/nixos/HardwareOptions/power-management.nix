{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    power-management.enable = lib.mkEnableOption "enables power-managements settings";
  };

  config = lib.mkIf config.power-management.enable {
    powerManagement.enable = true;
    powerManagement.powertop.enable = true;
  };
}
