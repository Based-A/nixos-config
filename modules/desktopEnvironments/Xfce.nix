{
  pkgs,
  lib,
  config,
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

      (google-fonts.override {
        fonts = [
          "Rubik"
        ];
      })
      nerd-fonts.jetbrains-mono
      font-awesome_5
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
    };
  };
}
