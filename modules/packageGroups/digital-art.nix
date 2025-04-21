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
    digital-art.enable = lib.mkEnableOption "adds digital art packages";
  };

  config = lib.mkIf config.digital-art.enable {
    environment.systemPackages = with pkgs; [
      gimp
      krita
      inkscape-with-extensions
      inputs.blender-LTS.packages.${pkgs.system}.blender_3_6
      #davinci-resolve
      opentabletdriver # tablet drivers
    ];
  };
}