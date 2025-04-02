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
      btop
      fzf

      #stylix
      base16-schemes
    ];
  };

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
    image = ./../../hosts/adam/adamBackground.jpg;
    imageScalingMode = "fill";
    polarity = "dark";
    /*targets = {
      qt.enable = false;
      kde.enable = false;
    };*/
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
        "background-opacity" = 0.9;
        "foreground" = "c8d3f5";
        "font-family" = "Fira Code";
      };
    };
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
