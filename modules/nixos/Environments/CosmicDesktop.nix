{
  pkgs,
  lib,
  config,
  inputs,
  host,
  ...
}:
{
  options = {
    CosmicDE.enable = lib.mkEnableOption "enables the System76 COSMIC desktop";
  };
# Currently broken, will remove when fixed.
  config = lib.mkIf config.CosmicDE.enable {    
    { # COSMIC
      nix.settings = {
        substituters = [ "https://cosmic.cachix.org/" ];
        trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
      };
    }

    services = {
      xserver = {
        enable = false;
        xkb = {
          layout = "us";
          variant = "";
        };
      };

      desktopManager.cosmic.enable = true;
      
      displayManager = {
        cosmic-greeter.enable = true;
        autoLogin = {
          enable = true;
          user = "adam";
        };
      };
    };

    xdg.portal = {
      enable = true;
      wlr.enable = false;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal
      ];
    };

    programs = {

    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      COSMIC_DATA_CONTROL_ENABLED = "1";
    };

    home-manager.sharedModules = [ #Will all have to be moved to home.nix when enabled.
      {
        home = {
          packages = with pkgs; [
            #system components
            egl-wayland

            btop
            sysz
            fzf

            (google-fonts.override {
              fonts = [
                "Ubuntu Mono"
                "SUSE"
              ];
            })
          ];

          file = {
            #ghostty = {
            #  source = ../../config; #Create ghostty config file
            #};
          };

        };

        wayland.desktopManager.cosmic = {
          enable = true;
          appearance = {
            theme = {
              dark = {
                active_hint = 3;
                corner_radii = {
                  radius_0 = cosmicLib.cosmic.mkRon "tuple" [
                    0.0
                    0.0
                    0.0
                    0.0
                  ];
                  radius_l = cosmicLib.cosmic.mkRon "tuple" [
                    32.0
                    32.0
                    32.0
                    32.0
                  ];
                  radius_m = cosmicLib.cosmic.mkRon "tuple" [
                    16.0
                    16.0
                    16.0
                    16.0
                  ];
                  radius_s = cosmicLib.cosmic.mkRon "tuple" [
                    8.0
                    8.0
                    8.0
                    8.0
                  ];
                  radius_xl = cosmicLib.cosmic.mkRon "tuple" [
                    160.0
                    160.0
                    160.0
                    160.0
                  ];
                  radius_xs = cosmicLib.cosmic.mkRon "tuple" [
                    4.0
                    4.0
                    4.0
                    4.0
                  ];
                };
                gaps = cosmicLib.cosmic.mkRon "tuple" [
                  0
                  8
                ];
                spacing = {
                  space_l = 32;
                  space_m = 24;
                  space_none = 0;
                  space_s = 16;
                  space_xl = 48;
                  space_xs = 12;
                  space_xxl = 64;
                  space_xxs = 8;
                  space_xxxl = 128;
                  space_xxxs = 4;
                };
                
              };
            };
            toolkit = {
              apply_theme_global = true;
              header_size = "Compact";
              icon_theme = "Cosmic";
              interface_density = "Compact";
              interface_font = {
                family = "SUSE";
                stretch = cosmicLib.cosmic.mkRon "enum" "Normal";
                style = cosmicLib.cosmic.mkRon "enum" "Normal";
                weight = cosmicLib.cosmic.mkRon "enum" "Normal";
              };
              monospace_font = {
                family = "Ubuntu Mono";
                stretch = cosmicLib.cosmic.mkRon "enum" "Normal";
                style = cosmicLib.cosmic.mkRon "enum" "Normal";
                weight = cosmicLib.cosmic.mkRon "enum" "Normal";
              };
              show_maximize = true;
              show_minimize = true;
            };
          };
          applets = {
            app-list = {
              settings = {
                enable_drag_source = false;
                favorites = [
                  "com.system76.CosmicFiles"
                  "com.system76.CosmicSettings"
                  "app.zen_browser.zen"
                  "code"
                  "obsidian"
                  "vesktop"
                  "steam"
                  "Blender (Latest)"
                  "krita"
                  "thunderbird"
                ];
              };
            };
            audio = {
              settings = {
                show_media_controls_in_top_panel = true;
              };
            };
            time = {
              settings = {
                first_day_of_week = 6;
                military_time = true;
                show_date_in_top_panel = true;
                show_seconds = false;
                show_weekday = true;

              };
            };
          };
          compositor = {
            active_hint = true;
            autotile = false;
            autotile_behavior = "PerWorkspace";
            cursor_follows_focus = false;
            #descale_xwayland = false;
            focus_follows_cursor = false;
            input_default = {
              acceleration = {
                profile = cosmicLib.cosmic.mkRon "optional" (cosmicLib.cosmic.mkRon "enum" "Flat");
                speed = 0.0;
              };
              left_handed = false;
              middle_button_emulation = false;
              state = cosmicLib.cosmic.mkRon "enum" "Enabled";
            };
            workspaces = {
              workspace_layout = cosmicLib.cosmic.mkRon "Horizontal";
              workspace_mode = cosmicLib.cosmic.mkRon "OutputBound";
            };
            xkb_config = {
              layout = "us";
              repeat_delay = 300;
              repeat_rate = 40;
            };
          };
          idle = {
            screen_off_time = 300000;
            suspend_on_ac_time = 600000;
            suspend_on_battery_time = 300000;
          };
          installCli = true;
          installCosmicCtl = true;
          panels = [
            {
              anchor = cosmicLib.cosmic.mkRon "enum" "Bottom";
              anchor_gap = true;
              autohide = cosmicLib.cosmic.mkRon "optional" {
                handle_size = 4;
                transition_time = 200;
                wait_time = 1000;
              };
              background = cosmicLib.cosmic.mkRon "enum" "Dark";
              expand_to_edges = true;
              name = "Pete";
              opacity = 0.5;
              output = cosmicLib.cosmic.mkRon "enum" "All";
              plugins_center = cosmicLib.cosmic.mkRon "optional" [
                "com.system76.CosmicPanelWorkspacesButton"
              ];
              plugins_wings = cosmicLib.cosmic.mkRon "optional" (cosmicLib.cosmic.mkRon [
                [
                  "com.system76.CosmicPanelAppButton"
                ]
                [
                  "com.system76.CosmicAppletStatusArea"
                  "com.system76.CosmicAppletInputSources"
                  "com.system76.CosmicAppletTiling"
                  "com.system76.CosmicAppletAudio"
                  "com.system76.CosmicAppletNetwork"
                  "com.system76.CosmicAppletBattery"
                  "com.system76.CosmicAppletNotifications"
                  "com.system76.CosmicAppletBluetooth"
                  "com.system76.CosmicAppletPower"
                ]
              ]);
              size = cosmicLib.cosmic.mkRon "enum" "M";
            }
          ];
          resetFiles = true;
          #shortcuts = -TBD
          wallpapers = {
            filter_by_theme = false;
            filter_method = cosmicLib.cosmic.mkRon "enum" "Linear";
            output = "all";
            scaling_mode = cosmicLib.cosmic.mkRon "enum" "Zoom";
            source = cosmicLib.cosmic.mkRon "../../../../CosmicBackground.png";
          };
        };

        programs = {
          cosmic-file = {
            enable = true;
            settings = {
              app_theme = "Dark";
              desktop = {
                show_content = false;
                show_mounted_drives = false;
                show_trash = false;
              };
              favorites = [
                (cosmicLib.cosmic.mkRon "enum" "Home")
                (cosmicLib.cosmic.mkRon "enum" "Documents")
                (cosmicLib.cosmic.mkRon "enum" "Downloads")
                (cosmicLib.cosmic.mkRon "enum" "Music")
                (cosmicLib.cosmic.mkRon "enum" "Pictures")
                (cosmicLib.cosmic.mkRon "enum" "Videos")
              ];
              show_details = true;
              tab = {
                folders_first = true;
                icon_sizes = {
                  grid = 100;
                  list = 100;
                };
                show_hidden = false;
                view = "List";
              };
            };
          };
        };

        fonts.fontconfig = {
          enable = true;
          defaultFonts = {
            monospace = [
              "Ubuntu Mono"
            ];
            sansSerif = [
              "SUSE"
            ];
          };
        };
      }
    ];
  };
}