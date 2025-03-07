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
      #VS Code
      vscode
      nixfmt-rfc-style
      nixd

      # General Apps
      obsidian
      brave
      thunderbird
      libreoffice
      #inputs.ghostty.packages."${pkgs.system}".default
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
      fastfetch
      nushell
      toybox
      btop
      sysz
      fzf

      #stylix
      base16-schemes
    ];
  };

  stylix = {
    enable = false;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-moon.yaml";
    image = ./../../hosts/adam/adamBackground.jpg;
    imageScalingMode = "fill";
    polarity = "dark";
    targets = {
      qt.enable = false;
      kde.enable = false;
    };
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

    vscode.profiles.default = {
      enable = true;
      enableExtensionUpdateCheck = true;
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        formulahendry.code-runner
        johnpapa.vscode-peacock
        ms-azuretools.vscode-docker
        eamodio.gitlens
        ms-vscode-remote.remote-ssh
        pnp.polacode
        pkief.material-icon-theme
        tomoki1207.pdf
        mechatroner.rainbow-csv
        usernamehw.errorlens
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
        "editor.cursorBlinking" = "expand";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.wordWrap" = "on";
      };
    };

    ghostty = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        "background-opacity" = 0.8;
      };
    };

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
