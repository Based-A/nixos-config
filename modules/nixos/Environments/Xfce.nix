{
  pkgs,
  lib,
  config,
  host,
  ...
}:
{
  options = {
    Xfce.enable = lib.mkEnableOption "enables Xfce desktop";
  };

  config = lib.mkIf config.Xfce.enable {
    services = {
      xserver = {
        enable = false;
        xkb = {
          layout = "us";
          variant = "";
        };
        desktopManager = {
          xterm.enable = false;
          xfce = {
            enable = true;
            enableXfwm = false;
            enableWaylandSession = true;
            noDesktop = true;
          };
        };
      };
      displayManager = {
        sddm.enable = true;
	      sddm.wayland.enable = true;
        defaultSession = "wayfire";
      };
    };

    programs.wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    environment.systemPackages = with pkgs; [
      mako
      swaylock
      wlogout
      waybar
      wofi
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
