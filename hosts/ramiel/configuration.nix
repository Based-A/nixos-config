{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    #./hardware-configuration.nix
    ./../../modules
    inputs.sops-nix.nixosModules.sops
  ];
  /*
    TODO:
    Homepage - Dashboard
    Leantime Container
    Nextcloud Container
    Mattermost Container
    Forgejo Container
    Jenkins Container
  */
  # Modules

  ## HardwareOptions
  file-cleanup.enable = true;

  ## Services
  podman.enable = true;

  ## Other
  shellAliases.enable = true;

  #System Packages
  environment.systemPackages = with pkgs; [

  ];

  users = {
    users = {
      ramiel = {
        isNormalUser = true;
        description = "ramiel-server";
        uid = 1004;
        group = "ramiel-server";
      };
      adam.isNormalUser = true;
    };
    groups = {
      ramiel-server = { };
    };
  };

  # Boot Options
  boot = {
    loader = {
      timeout = 5;
    };
    kernelPackages = pkgs.linuxPackages;
  };

  # Networking Options
  networking = {
    hostName = "ramiel-nixos"; # Define your hostname.
    networkmanager.enable = true; # Enable networking.
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    firewall.allowedUDPPorts = [
    ]; # Open ports in the firewall.
  };

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
