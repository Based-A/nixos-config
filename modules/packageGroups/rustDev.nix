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
    rustDev.enable = lib.mkEnableOption "enables core Rust development tools";
  };

  config = lib.mkIf config.rustDev.enable {
    environment = {
      systemPackages = with pkgs; [
        cargo
        rustc
        rustPlatform.bindgenHook
        pkg-config
        clang_20
        mold
        udev
        alsa-lib
        zola # Website
        mold
      ];

      variables = {
        MOLD_LINKER = "${pkgs.mold}";
      };
    };
  };
}