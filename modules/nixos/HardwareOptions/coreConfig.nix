{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # Local System Info
  ## Set your time zone.
  time.timeZone = "America/Edmonton";

  ## Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  hardware = {
    enableAllFirmware = true;
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;
}