{
  lib,
  ...
}:
{
  imports = [
    # App Services
    ./appServices/home-assistant.nix
    ./appServices/nextcloud-server.nix
    ./appServices/podman.nix
    ./appServices/sunshine.nix

    # Containers
    ./nixContainers/resolve_db_container.nix
    ./nixContainers/appflowy-cloud-service.nix

    # Desktop Environments
    ./desktopEnvironments/Plasma6.nix
    ./desktopEnvironments/Xfce.nix
    ./desktopEnvironments/Cosmic.nix
    ./desktopEnvironments/NiriWM.nix

    # Hardware Options
    ./hardwareOptions/bluetooth.nix
    ./hardwareOptions/coreConfig.nix
    ./hardwareOptions/file-cleanup.nix
    ./hardwareOptions/nvidia-graphics.nix
    ./hardwareOptions/power-management.nix

    # Package Groups
    ./packageGroups/audio-apps.nix
    ./packageGroups/corePackages.nix
    ./packageGroups/digital-art.nix
    ./packageGroups/rustDev.nix
    ./packageGroups/utilities.nix

  ];

  # Module Defaults
  home-assistant.enable = lib.mkDefault false;
  nextcloud-server.enable = lib.mkDefault false;
  podman.enable = lib.mkDefault false;
  sunshine.enable = lib.mkDefault false;

  resolve_db.enable = lib.mkDefault false;
  appflowy_db.enable = lib.mkDefault false;

  Plasma6.enable = lib.mkDefault false;
  Xfce.enable = lib.mkDefault false;
  Cosmic.enable = lib.mkDefault false;
  NiriWM.enable = lib.mkDefault false;

  bluetooth.enable = lib.mkDefault false;
  file-cleanup.enable = lib.mkDefault true;
  nvidia-graphics.enable = lib.mkDefault false;
  power-management.enable = lib.mkDefault false;

  audio-apps.enable = lib.mkDefault false;
  corePackages.enable = lib.mkDefault false;
  digital-art.enable = lib.mkDefault false;
  rustDev.enable = lib.mkDefault false;
  utilities.enable = lib.mkDefault false;
}
