{
  pkgs,
  lib,
  config,
  host,
  ...
}:
{
  options = {
    XfceWayfire.enable = lib.mkEnableOption "enables Xfce with Wayfire WM desktop";
  };

  config = lib.mkIf config.XfceWayfire.enable {
    services = {
      xserver = {
        enable = true;
        xkb = {
          layout = "us";
          variant = "";
        };
        desktopManager = {
          xterm.enable = false;
          xfce = {
            enable = true;
            noDesktop = true;
            enableXfwm = false;
            enableWaylandSession = true;
          };
        };
      };
      displayManager = {
        defaultSession = "wayfire";
      };
    };

    programs.wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
      ];
    };

    programs.xwayland.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
