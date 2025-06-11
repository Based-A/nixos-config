{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    corePackages.enable = lib.mkEnableOption "core packages";
  };

  config = lib.mkIf config.corePackages.enable {
    programs = {
      yazi.enable = true;
    };
    environment = {
      systemPackages = with pkgs; [
        obsidian # knowledge base
        brave # chromium-based browser
        thunderbird # email client
        libreoffice # office suite
        (discord.override {
          withVencord = true;
        }) # better discord
        ncspot # tui spotify client
        nushell # cool shell
        zed-editor # text editor
        fzf # fuzzy finder
        zoxide # smart cd tool
        stown # dotfile manager
        rio # terminal emulator

        vscode-fhs
        bashFHS
      ];
      etc = {
        "links/nushell".source = "${pkgs.nushell}/bin/nu";
        "links/zed-editor".source = "${pkgs.zed-editor}/bin/zeditor";
      };
    };
  };
}
