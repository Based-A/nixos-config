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
      vesktop
      inputs.ghostty.packages."${pkgs.system}".default

      # Utilities
      zip
      unzip
      handbrake
      qbittorrent
      obs-studio
      vlc
      localsend
      fastfetch
    ];
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

    vscode = {
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

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
