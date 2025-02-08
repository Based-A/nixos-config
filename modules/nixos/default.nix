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
    ./HardwareOptions/nvidia-graphics.nix
    ./HardwareOptions/power-management.nix
    # User Lists
    ./HardwareOptions/userList.nix

    # Services
    ./Services/docker.nix
    ./Services/home-assistant.nix
    ./Services/nextcloud-server.nix
    ./Services/plex.nix
    ./Services/podman.nix
    ./Services/sunshine.nix

    # Packages
    ./Packages/audio-apps.nix
    ./Packages/digital-art.nix
    ./Packages/game-dev.nix

    # Environments
    ./Environments/Plasma6.nix
#    ./Environments/CosmicDesktop.nix COSMIC doesn't build, will enable when fixed.
    ./Environments/XfceWayfire.nix
  ];

  # Module Defaults
  shellAliases.enable = lib.mkDefault true;

  bluetooth.enable = lib.mkDefault false;
  file-cleanup.enable = lib.mkDefault true;
  nvidia-graphics.enable = lib.mkDefault false;
  power-management.enable = lib.mkDefault false;

  docker.enable = lib.mkDefault false;
  home-assistant.enable = lib.mkDefault false;
  nextcloud-server.enable = lib.mkDefault false;
  plex.enable = lib.mkDefault false;
  podman.enable = lib.mkDefault false;
  sunshine.enable = lib.mkDefault false;

  audio-apps.enable = lib.mkDefault false;
  digital-art.enable = lib.mkDefault false;
  game-dev.enable = lib.mkDefault false;

  Plasma6.enable = lib.mkDefault false;
#  CosmicDE.enable = lib.mkDefault false; COSMIC doesn't build, will enable when fixed.
  XfceWayfire.enable = lib.mkDefault false;
}
