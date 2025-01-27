{
  inputs,
  config,
  pkgs,
  lib,
  user,
  ...
}:

{
  imports = [
    ./../../modules/home-manager
  ];

  home = {
    username = "adam";
    homeDirectory = lib.mkDefault "/home/adam";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [

      #Plasma6
      kdePackages.plasma-browser-integration
      kdePackages.kwallet-pam
      kdePackages.plasma-workspace
      kdePackages.plasma-nm
      kdePackages.plasma-pa
      kdePackages.kdeplasma-addons
      kdePackages.qtwebengine
      kdePackages.qtmultimedia
      kdePackages.qtwebsockets
      #Plasma6 Fonts
      (google-fonts.override {
        fonts = [
          "Inconsolata"
          "Hanken Grotesk"
          "Besley"
          "Fira Code"
        ];
      })

      #General Packages
      btop
      sysz
      fzf

      #Wayland
      egl-wayland
    ];
  };
  programs.git = {

    enable = true;
    userName = "adam";
    userEmail = "adamlundrigan1@gmail.com";
    extraConfig = {

      init.defaultBranch = "main";
      safe.directory = "/home/flake";
    };
  };

  programs.vscode = {

    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = false;

    extensions = with pkgs.vscode-extensions; [

      formulahendry.code-runner

      jnoortheen.nix-ide

      ms-vscode.cmake-tools
      llvm-vs-code-extensions.vscode-clangd
      ms-dotnettools.csharp

      sdras.night-owl
    ];

    userSettings = lib.mkForce {

      "[nix]"."serverPath" = "nixd";
      "[nix]"."enableLanguageServer" = "true";
      "[nix]"."serverSettings"."nixd"."nixpkgs"."expr" = "import <nixpkgs> { }";
      "[nix]"."serverSettings"."nixd"."formatting"."command" = "[nixfmt]";
      "[nix]"."serverSettings"."nixd"."options"."nixos"."expr" = "(builtins.getFlake \"/home/flake\").nixosConfigurations.adam.options";

      "update.mode" = "none";
      "workbench.colorTheme" = "Night Owl (No Italics)";
      "explorer.confirmDragAndDrop" = false;
      "editor.fontFamily" = "'Fira Code'";
      "terminal.integrated.fontFamily" = "'Inconsolata'";
    };
  };

  #Plasma-Manager Options
  programs = {
    plasma = {
      enable = true;
      overrideConfig = true;
      windows.allowWindowsToRememberPositions = true;

      configFile = {
        kded5rc = {
          "Module-gtkconfig"."autoload" = false;
        };
        kded6rc = {
          "PlasmaBrowserIntegration"."shownCount" = "0";
        };
        kwalletrc = {
          "Wallet"."Close When Idle" = false;
          "Wallet"."Close on Screensaver" = false;
          "Wallet"."Default Wallet" = "kdewallet";
          "Wallet"."Enabled" = true;
          "Wallet"."First Use" = false;
          "Wallet"."Idle Timeout" = 10;
          "Wallet"."Launch Manager" = false;
          "Wallet"."Leave Manager Open" = false;
          "Wallet"."Leave Open" = true;
          "Wallet"."Prompt on Open" = true;
          "Wallet"."Use One Wallet" = true;
          "org.freedesktop.secrets"."apiEnabled" = true;
          "Auto Allow"."kdewallet" = "Code,discord,xdg-desktop-portal,kded6";
        };
      };

      fonts = {
        fixedWidth = {
          family = "Inconsolata";
          pointSize = 12;
        };
        general = {
          family = "Hanken Grotesk";
          pointSize = 12;
        };
        menu = {
          family = "Hanken Grotesk";
          pointSize = 12;
        };
        small = {
          family = "Hanken Grotesk";
          pointSize = 8;
        };
        toolbar = {
          family = "Hanken Grotesk";
          pointSize = 12;
        };
        windowTitle = {
          family = "Hanken Grotesk";
          pointSize = 10;
        };
      };

      input = {
        keyboard = {
          layouts = [
            {
              layout = "us";
            }
          ];
          numlockOnStartup = "on";
          repeatDelay = 300;
          repeatRate = 40;
        };
        
        mice = [
          {
            acceleration = 0;
            accelerationProfile = "none";
            enable = true;
            leftHanded = false;
            middleButtonEmulation = false;
            name = "SteelSeries SteelSeries Aerox 3 Wireless";
            naturalScroll = false;
            productId = "183a";
            scrollSpeed = 1;
            vendorId = "1038";
          }
          {
            acceleration = 0;
            accelerationProfile = "none";
            enable = true;
            leftHanded = false;
            middleButtonEmulation = false;
            name = "Logitech USB Receiver Mouse";
            naturalScroll = false;
            productId = "c548";
            scrollSpeed = 1;
            vendorId = "046d";
          }
        ];
      };

      krunner = {
        activateWhenTypingOnDesktop = true;
        historyBehavior = "enableSuggestions";
        position = "top";
      };

      kscreenlocker = {
        autoLock = false;
        lockOnResume = false;
        lockOnStartup = false;
        passwordRequired = false;
      };

      kwin = {
        cornerBarrier = false;
        edgeBarrier = 0;
        effects = {
          blur.enable = true;
          cube.enable = false;
          desktopSwitching.animation = "fade";
          dimAdminMode.enable = true;
          dimInactive.enable = false;
          fallApart.enable = false;
          fps.enable = false;
          minimization.animation = "off";
          shakeCursor.enable = false;
          slideBack.enable = false;
          snapHelper.enable = false;
          translucency.enable = true;
          windowOpenClose.animation = "glide";
          wobblyWindows.enable = false;
        };

        nightLight = {
          enable = true;
          mode = "times";
          time.evening = "20:00";
          time.morning = "08:00";
          transitionTime = 30;
        };
      };

      panels = [
        {
          lengthMode = "fill";
          floating = true;
          height = 40;
          hiding = "dodgewindows";
          location = "bottom";
          screen = "all";
          widgets = [
            {
              kickerdash = {
                icon = "nix-snowflake-white";
                applicationNameFormat = "nameOnly";
                categories = {
                  show = {
                    recentApplications = true;
                    recentFiles = true;
                  };
                  order = "recentFirst";
                };
              };
            }
            {
              name = "zayron.simple.separator";
              config = {
                lengthMargin = "25";
                lengthSeparator = "80";
                opacity = "30";
              };
            }
            "org.kde.plasma.panelspacer"
            {
              iconTasks = {
                iconsOnly = true;
                appearance = {
                  indicateAudioStreams = true;
                  iconSpacing = "medium";
                };
                behavior = {
                  grouping.method = "byProgramName";
                  sortingMethod = "alphabetically";
                };
                launchers = [
                  "preferred://browser"
                  "preferred://filemanager"
                  "applications:com.mitchellh.ghostty.desktop"
                  "applications:code.desktop"
                  "applications:obsidian.desktop"
                  "applications:vesktop.desktop"
                  "applications:thunderbird.desktop"
                  "applications:steam.desktop"
                  "applications:Blender (Latest).desktop"
                  "applications:org.kde.krita.desktop"
                ];
              };
            }
            "org.kde.plasma.panelspacer"
            {
              name = "ChatAI-Plasmoid";
            }
            {
              name = "zayron.simple.separator";
              config = {
                lengthMargin = "25";
                lengthSeparator = "80";
                opacity = "30";
              };
            }
            {
              systemTray = {
                items = {
                  shown = [
                    "org.kde.plasma.bluetooth"
                    "org.kde.plasma.volume"
                    "org.kde.plasma.notifications"
                  ];
                  hidden = [
                    "org.kde.plasma.networkmanagement"
                    "org.kde.plasma.clipboard"
                    "org.kde.plasma.cameraindicator"
                    "org.kde.plasma.manage-inputmethod"
                    "org.kde.plasma.devicenotifier"
                    "org.kde.plasma.keyboardlayout"
                    "org.kde.plasma.keyboardindicator"
                    "org.kde.plasma.printmanager"
                    "org.kde.kscreen"
                    "org.kde.plasma.brightness"
                    "org.kde.plasma.battery"
                    "org.kde.plasma.networkmanagement"
                    "org.kde.plasma.weather"
                  ];
                };
              };
            }
            {
              digitalClock = {
                calendar.firstDayOfWeek = "sunday";
                date.enable = true;
                date.format.custom = "MM/dd/yy";
                date.position = "belowTime";
                time.format = "24h";
                time.showSeconds = "always";
              };
            }
            {
              name = "com.himdek.kde.plasma.overview";
            }
          ];
        }
      ];

      powerdevil.AC = {
        autoSuspend.action = "nothing";
        dimDisplay.enable = true;
        dimDisplay.idleTimeout = 300;
        powerButtonAction = "shutDown";
        turnOffDisplay.idleTimeout = 600;
      };

      window-rules = [
        {
          description = "Obsidian";
          match = {
            window-class = {
              value = "electron obsidian";
              type = "substring";
            };
            window-types = [ "normal" ];
          };
          apply = {
            desktops = "b81d2858-98c1-47bd-9984-85da52bfab23";
            desktopsrule = "3";
            maximizehoriz = "true";
            maximizehorizrule = "3";
            maximizevert = "true";
            maximizevertrule = "3";
            position = "2560,0";
            positionrule = "3";
            screen = "1";
            screenrule = "3";
          };
        }
        {
          description = "Zen Browser";
          match = {
            window-class = {
              value = "zen-alpha";
              type = "substring";
            };
            window-types = [ "normal" ];
          };
          apply = {
            desktops = "b81d2858-98c1-47bd-9984-85da52bfab23";
            desktopsrule = "3";
            screen = "0";
            screenrule = "3";
          };
        }
        {
          description = "VS Code";
          match = {
            window-class = {
              value = "code code-url-handler";
              type = "exact";
            };
            window-types = [ "normal" ];
          };
          apply = {
            desktops = "b81d2858-98c1-47bd-9984-85da52bfab23";
            desktopsrule = "3";
            screen = "1";
            screenrule = "3";
          };
        }
      ];

      workspace = {
        clickItemTo = "select";
        colorScheme = "BreezeDark";
        cursor.theme = "Win10OS-cursors";
        iconTheme = "Papirus-Dark";
        splashScreen.theme = "Breeze";
        theme = "Gently";
        wallpaper = "/home/flake/hosts/adam/adamBackground.jpg";
        windowDecorations.library = "org.kde.kwin.aurorae";
        windowDecorations.theme = "__aurorae__svg__WillowDarkBlur";
      };
    };

    konsole = {
      enable = true;
      defaultProfile = "adamDefault";
      profiles = {
        adamDefault = {
          font.name = "Inconsolata";
          font.size = 12;
          name = "adamDefault";
        };
      };
    };

    okular = {
      enable = true;
      general = {
        openFileInTabs = true;
        zoomMode = "fitPage";
      };
    };

    kate = {
      enable = false;
    };
  
    ghostwriter = {
      enable = false;
    };
  };


  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [
        "Inconsolata"
      ];
      sansSerif = [
        "Hanken Grotesk"
      ];
      serif = [
        "Besley"
      ];
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
