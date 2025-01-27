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
    audio-apps.enable = lib.mkEnableOption "adds audio work apps";
  };

  config = lib.mkIf config.audio-apps.enable {
    environment.systemPackages = with pkgs; [
      ardour
      tenacity
    ];
  };
}