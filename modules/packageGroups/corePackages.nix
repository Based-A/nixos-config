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
    };
    environment = {
      systemPackages = with pkgs; [
        brave # chromium-based browser
        vesktop # better discord
        nushell # cool shell
        zed-editor # text editor
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
        "links/nushell".source = "${pkgs.nushell}/bin/nu";
        "links/zed-editor".source = "${pkgs.zed-editor}/bin/zeditor";
      };
    };
  };
}
