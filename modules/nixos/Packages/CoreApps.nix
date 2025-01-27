{
  pkgs,
  inputs,
  lib,
  config,
  host,
  ...
}:
{

  options = {
    CoreApps.enable = lib.mkEnableOption "adds a core group of essential and useful applications";
  };

  config = lib.mkIf config.CoreApps.enable {
    environment.systemPackages = with pkgs; [
      # Apps
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
}