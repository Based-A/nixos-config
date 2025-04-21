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

  plasmaManager.enable = true;

  home = {
    username = "adam";
    homeDirectory = lib.mkDefault "/home/adam";
    stateVersion = "24.05"; # Please read the comment before changing.

    packages = with pkgs; [
      vscode
      nixfmt-rfc-style
      nixd

      # General Apps
      obsidian
      appflowy
      brave
      thunderbird
      libreoffice
      ghostty
      (discord.override {
        withVencord = true;
      })

      # Utilities
      zip
      unzip
      handbrake
      qbittorrent
      obs-studio
      vlc
      localsend
      nushell
      btop
      sourcegit #gui git client

      #stylix
      base16-schemes
    ];
  };

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
    image = ./../../hosts/bebopBackground.png;
    imageScalingMode = "fill";
    polarity = "dark";
  };
  
  programs = {
    git = {
      enable = true;
      userName = "adam";
      userEmail = "adamlundrigan1@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = "/home/flake";
      };
    };
    ghostty = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        "font-family" = "Fira Code";
      };
    };
    vscode = {
      enable = true;
      package = pkgs.vscode;
      profiles.default = {
        enableExtensionUpdateCheck = true;
        enableUpdateCheck = false;
        userSettings = lib.mkForce {
          "[nix]"."serverPath" = "nixd";
          "[nix]"."enableLanguageServer" = "true";
          "[nix]"."serverSettings"."nixd"."nixpkgs"."expr" = "import <nixpkgs> { }";
          "[nix]"."serverSettings"."nixd"."formatting"."command" = "[nixfmt]";
          "explorer.confirmDragAndDrop" = false;
          "editor.fontFamily" = "'Fira Code'";
          "terminal.integrated.fontFamily" = "'Inconsolata'";
          "editor.cursorBlinking" = "expand";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.wordWrap" = "on";
          "rust-analyzer.cargo.extraEnv"."RUSTFLAGS" = "-Clinker=clang -Clink-arg=-fuse-ld=mold";
        };
        extensions = with pkgs.vscode-extensions; [
          fill-labs.dependi
          formulahendry.code-runner
          gruntfuggly.todo-tree
          jnoortheen.nix-ide
          johnpapa.vscode-peacock
          pkief.material-icon-theme
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
          usernamehw.errorlens
          vadimcn.vscode-lldb
        ];
      };
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
