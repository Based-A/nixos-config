{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    utilities.enable = lib.mkEnableOption "adds audio work apps";
  };

  config = lib.mkIf config.utilities.enable {
    environment.systemPackages = with pkgs; [
      zip
      unzip
      #handbrake
      qbittorrent
      obs-studio
      vlc
      localsend
      btop
      sourcegit # gui git client
      presenterm
    ];
  };
}
