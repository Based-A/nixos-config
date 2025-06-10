{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    NiriWM.enable = lib.mkEnableOption "enables niri wm and additional programs";
  };
  config = lib.mkIf config.NiriWM.enable {
    services.displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
      #      autoLogin = {
      #        enable = true;
      #        user = "adam";
      #      };
    };

    programs = {
      niri.enable = true; # Niri Compositor
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        gnome-keyring
      ];
    };

    environment.systemPackages = with pkgs; [
      kickoff # Program Launcher
      ironbar # Panel
      swww # Wallpaper Manager
      swaynotificationcenter # Notification Daemon
      clapboard # Clipboard Manager
      ianny # Anti Fatigue
      wluma # Brightness Control
      swayidle # Screen Idle
      swaylock # Screenlocker
      wleave # Logout Menu
      kdePackages.polkit-kde-agent-1 # Authentican Agent
      xwayland-satellite # XWayland Windowing
    ];

    fonts = {
      packages = with pkgs; [
        (google-fonts.override {
          fonts = [
            "Lato" # System / Sans-Serif Font
            "IBM Plex Mono" # Mono Font
            "Playfair Display" # Serif Font
          ];
        })
        nerd-fonts.symbols-only # NerdFont Symbols
      ];
      fontconfig = {
        defaultFonts = {
          sansSerif = [ "Lato" ];
          serif = [ "Playfair Display" ];
          monospace = [ "IBM Plex Mono" ];
        };
      };
    };

    boot.extraModprobeConfig = ''
      options nvidia_modeset vblank_sem_control=0
    '';

    /*
      dotfiles left to configure:
      - Yazi
      - swayidle
      - swaylock
      - ianny
      - Ironbar
      - Niri (keybindings)
      - clapboard?
      - wluma

      Colour Scheme {
      base00 = "CCCCCC";
      base01 = "C2C2C2";
      base02 = "B8B8B8";
      base03 = "AEAEAE";
      base04 = "A4A4A4";
      base05 = "9A9A9A";
      base06 = "909090";
      base07 = "868686";
      base08 = "7C7C7C";
      base09 = "727272";
      base0A = "686868";
      base0B = "5E5E5E";
      base0C = "545454";
      base0D = "4A4A4A";
      base0E = "474747";
      base0F = "333333";
      };
    */
  };

}
