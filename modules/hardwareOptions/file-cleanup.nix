{
  lib,
  config,
  ...
}:
{
  options = {
    file-cleanup.enable = lib.mkEnableOption "enables file-cleanup";
  };

  config = lib.mkIf config.file-cleanup.enable {
    boot = {
      tmp.cleanOnBoot = true;
    };

    nix = {
      optimise.automatic = true;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than-14d";
      };
    };
  };
}
