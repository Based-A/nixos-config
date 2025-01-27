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
    ./HardwareOptions/sops-nix.nix
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
    ./Packages/codeAccess.nix
    ./Packages/CoreApps.nix
    ./Packages/digital-art.nix
    ./Packages/game-dev.nix

    # Environments
    ./Environments/Plasma6.nix
#    ./Environments/CosmicDesktop.nix COSMIC doesn't build, will enable when fixed.
  ];

  # Module Defaults
  shellAliases.enable = lib.mkDefault true;

  bluetooth.enable = lib.mkDefault false;
  file-cleanup.enable = lib.mkDefault true;
  nvidia-graphics.enable = lib.mkDefault false;
  power-management.enable = lib.mkDefault false;
  sops-nix.enable = lib.mkDefault true;

  docker.enable = lib.mkDefault false;
  home-assistant.enable = lib.mkDefault false;
  nextcloud-server.enable = lib.mkDefault false;
  plex.enable = lib.mkDefault false;
  podman.enable = lib.mkDefault false;
  sunshine.enable = lib.mkDefault false;

  audio-apps.enable = lib.mkDefault false;
  CoreApps.enable = lib.mkDefault false;
  digital-art.enable = lib.mkDefault false;
  game-dev.enable = lib.mkDefault false;

  Plasma6.enable = lib.mkDefault false;
#  CosmicDE.enable = lib.mkDefault false; COSMIC doesn't build, will enable when fixed.
}
