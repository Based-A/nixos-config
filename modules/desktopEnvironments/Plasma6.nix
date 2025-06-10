{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    Plasma6.enable = lib.mkEnableOption "enables plasma6 desktop";
  };
  config = lib.mkIf config.Plasma6.enable {
    services = {
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

    environment = {
      sessionVariables = {
        NIXOS_OZONE_WL = "1";
        MOZ_ENABLE_WAYLAND = "1";
      };
      plasma6.excludePackages = with pkgs.kdePackages; [
        plasma-browser-integration
        ark
        elisa
        gwenview
        okular
        kate
        khelpcenter
        dolphin
        baloo-widgets
        dolphin-plugins
        spectacle
        ffmpegthumbs
        krdp
      ];
    };

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
  };
}
