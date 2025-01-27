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
    game-dev.enable = lib.mkEnableOption "adds game dev apps";
  };

  config = lib.mkIf config.game-dev.enable {
    environment.systemPackages = with pkgs; [
      p4v
      p4
      p4d
      jetbrains-toolbox
    ];
  };
}