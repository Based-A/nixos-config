{
  lib,
  config,
  ...
}:
{
  options = {
    Cosmic.enable = lib.mkEnableOption "enables cosmic desktop";
  };
  config = lib.mkIf config.Cosmic.enable {
    services = {
      desktopManager.cosmic = {
        enable = true;
        xwayland.enable = true;
      };
      displayManager = {
        cosmic-greeter.enable = true;
        autoLogin = {
          enable = true;
          user = "adam";
        };
      };
    };

    programs.xwayland.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
