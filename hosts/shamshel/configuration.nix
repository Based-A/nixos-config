{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../modules/nixos
    inputs.sops-nix.nixosModules.sops
  ];

  # Modules

  ## HardwareOptions
  bluetooth.enable = true;
  file-cleanup.enable = true;
  nvidia-graphics.enable = false;
  power-management.enable = false;
  sops-nix.enable = true;

  ## Services
  docker.enable = false;
  #home-assistant.enable = true;
  #nextcloud-server.enable = true;
  plex.enable = false;
  podman.enable = true;
  sunshine.enable = false;

  ## Other
  shellAliases.enable = true;

  ## Desktop Environments
  Plasma6.enable = false;
  #CosmicDE.enable = false;

  # Boot Options
  boot = {
    loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
      };
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "ntfs" ];
  };

  # Networking Options
  networking = {
    hostName = "adam-nixos"; # Define your hostname.
    networkmanager.enable = true; # Enable networking.
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    firewall.allowedUDPPorts = [ 
      47800
      48002
      48010
    ]; # Open ports in the firewall.
  };

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  system.stateVersion = "24.05"; # Did you read the comment?

}
