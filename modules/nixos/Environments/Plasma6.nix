{
  pkgs,
  lib,
  config,
  host,
  ...
}:
{
  options = {
    Plasma6.enable = lib.mkEnableOption "enables plasma6 desktop";
  };
  config = lib.mkIf config.Plasma6.enable {
    services = {
      xserver = {
        xkb = {
          layout = "us";
          variant = "";
        };
      };
      desktopManager.plasma6.enable = true;
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
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
      KWIN_DRM_ALLOW_NVIDIA_COLORSPACE = "1";
      QT_QPA_PLATFORM = "wayland;xcb";
    };
  };
}
