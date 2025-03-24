{
  pkgs,
  lib,
  host,
  ...
}:
{
  imports = [
    # General
    ./shellAliases.nix

    # Hardware Options
    ./HardwareOptions/bluetooth.nix
    ./HardwareOptions/coreConfig.nix
    ./HardwareOptions/file-cleanup.nix
    ./HardwareOptions/nixLd.nix
    ./HardwareOptions/nvidia-graphics.nix
    ./HardwareOptions/power-management.nix

    # Services
    ./Services/home-assistant.nix
    ./Services/nextcloud-server.nix
    ./Services/podman.nix
    ./Services/sunshine.nix

    # Packages
    ./Packages/audio-apps.nix
    ./Packages/digital-art.nix

    # Environments
    ./Environments/Plasma6.nix
    ./Environments/Xfce.nix
  ];

  # Module Defaults
  shellAliases.enable = lib.mkDefault true;

  bluetooth.enable = lib.mkDefault false;
  file-cleanup.enable = lib.mkDefault true;
  nvidia-graphics.enable = lib.mkDefault false;
  power-management.enable = lib.mkDefault false;

  home-assistant.enable = lib.mkDefault false;
  nextcloud-server.enable = lib.mkDefault false;
  nixLd.enable = lib.mkDefault false;
  podman.enable = lib.mkDefault false;
  sunshine.enable = lib.mkDefault false;

  audio-apps.enable = lib.mkDefault false;
  digital-art.enable = lib.mkDefault false;

  Plasma6.enable = lib.mkDefault false;
  Xfce.enable = lib.mkDefault false;
}
