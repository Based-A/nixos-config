{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    digital-art.enable = lib.mkEnableOption "adds digital art packages";
  };

  config = lib.mkIf config.digital-art.enable {
    environment.systemPackages = with pkgs; [
      gimp
      krita
      inkscape-with-extensions
      #davinci-resolve
      opentabletdriver # tablet drivers
    ];
  };
}
