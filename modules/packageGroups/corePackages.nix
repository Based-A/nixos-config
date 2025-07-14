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
      direnv.enable = true;
      fish.enable = true;
    };
    environment = {
      systemPackages = with pkgs; [
        brave # chromium-based browser
        vesktop # better discord
        zed-editor # text editor
        obsidian # knowledge base
        thunderbird # email client
        libreoffice # office suite
        fzf # fuzzy finder
        zoxide # smart cd tool
        stown # dotfile manager
        rio # terminal emulator
        distrobox # linux vms
        syncthing # file sync
        sourcegit # visual git client
        gpu-screen-recorder-gtk # gpu screen recorder
      ];
      etc = {
        #"links/fish".source = "${pkgs.fish}/bin/fish";
        "links/zed-editor".source = "${pkgs.zed-editor}/bin/zeditor";
      };
    };
  };
}
