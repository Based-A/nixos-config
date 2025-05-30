{
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./plasmaManager.nix
  ];

  plasmaManager.enable = true;

  home = {
    username = "adam";
    homeDirectory = lib.mkDefault "/home/adam";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      # General Apps
      obsidian
      appflowy
      vivaldi
      thunderbird
      libreoffice
      ghostty
      (discord.override {
        withVencord = true;
      })
      manuskript
      ncspot
      presenterm

      # Utilities
      zip
      unzip
      handbrake
      qbittorrent
      obs-studio
      vlc
      localsend
      btop
      sourcegit # gui git client

      #stylix
      base16-schemes
    ];
  };

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-mirage.yaml";
    image = ./../../hosts/bebopBackground.png;
    imageScalingMode = "fill";
    polarity = "dark";

    targets = {
      zed.enable = false;
    };
  };

  programs = {
    # Fzf Fuzzy Finder Utility
    fzf = {
      enable = true;
    };
    # Git
    git = {
      enable = true;
      userName = "adam";
      userEmail = "adamlundrigan1@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/home/flake";
      };
    };
    # Rio Terminal Emulator
    rio = {
      enable = true;
      settings = {
        cursor = {
          shape = "beam";
          blinking = true;
        };
        fonts = {
          size = 16;
          family = "Fira Code";
        };
        navigation = {
          unfocused-split-opacity = 0.8;
        };
        renderer = {
          performance = "High";
          backend = "Automatic";
          disable-unfocused-render = true;
          target-fps = 144;
        };
        shell = {
          program = "${pkgs.nushell}/bin/nu";
        };
        window = {
          opacity = 0.9;
          blue = true;
          decorations = "Enabled";
        };
        line-height = 1.5;
        working-dir = "/home/";
      };
    };
    # Zed IDE
    zed-editor = {
      enable = true;
      extensions = [
        "nix"
        "toml"
        "html"
      ];
      extraPackages = [
        pkgs.nixd
        pkgs.clang_20
        pkgs.mold
      ];
      themes = {
        "mode" = "system";
        "light" = "One Light";
        "dark" = "Ayu Mirage";
      };
      userSettings = {
        terminal = {
          env = {
            TERM = "rio";
          };
          font_family = "Fira Code";
          shell = "system";
        };
        lsp = {
          rust-analyzer = {
            initialization_options = {
              rust = {
                analyzerTargetDir = true;
              };
            };
          };
          nix = {
            binary = {
              path_lookup = true;
            };
          };
        };
        ui_font_size = lib.mkForce 16.0;
        buffer_font_size = lib.mkForce 14.0;
      };
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
