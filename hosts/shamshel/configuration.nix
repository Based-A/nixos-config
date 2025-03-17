{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    #./hardware-configuration.nix
    ./../../modules/nixos
    ./../../diskoConfs/nixPi4-disk-config.nix
    inputs.sops-nix.nixosModules.sops
  ];

  # Modules

  ## HardwareOptions
  bluetooth.enable = true;
  file-cleanup.enable = true;
  nvidia-graphics.enable = false;
  power-management.enable = false;

  ## Services
  docker.enable = false;
  home-assistant.enable = true;
  #nextcloud-server.enable = true;
  plex.enable = false;
  podman.enable = true;
  sunshine.enable = false;

  ## Other
  shellAliases.enable = true;

  ## Desktop Environments
  Plasma6.enable = false;
  Xfce.enable = true;

  #System Packages
  environment.systemPackages = with pkgs; [
    libraspberrypi
  ];

  users.users = {
    nixPi = {
      isNormalUser = true;
      description = "nixPi";
      uid = 1003;
      group = "nixPi";
      extraGroups = [ "wheel" ];
    };
  };

  users.groups.nixPi = {};

  # Boot Options
  boot = {
    loader = {
      timeout = 5;
      raspberryPi.firmwareConfig = ''
        dtparam=audio=on
      '';
    };
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "snd_bcm2835.enable_hdmi=1"
      "snd_bcm2835.enable_headphones=1"
    ];
  };

  #Bluetooth on Pi4
  systemd.services.btattach = {
    before = [ "bluetooth.service" ];
    after = [ "dev-ttyAMA0.device" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.bluez}/bin/btattach -B /dev/ttyAMA0 -P bcm -S 3000000";
    };
  };

  # Networking Options
  networking = {
    hostName = "shamshel-nixos"; # Define your hostname.
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
