{
  config,
  pkgs,
  inputs,
  host,
  ...
}:

{
  #Raspberry Pi4
  imports = [
    # Include the results of the hardware scan.
    #./hardware-configuration.nix
    ./../../modules
    inputs.sops-nix.nixosModules.sops
    ./${host}-disko-config.nix
  ];
  /*
    TODO:
    Homepage - Dashboard
    Home Assistant - Automation
    Grocy - Shopping List
    Arr Apps - Media Server
    NGINX
    Pangolin/Tailscale/Cloudflare Tunnels/VPN
  */
  # Modules

  ## HardwareOptions
  bluetooth.enable = true;
  file-cleanup.enable = true;

  ## Services
  home-assistant.enable = true;
  podman.enable = true;

  ## Other
  shellAliases.enable = true;

  #System Packages
  environment.systemPackages = with pkgs; [
    #libraspberrypi
  ];

  users = {
    users = {
      nixPi = {
        isNormalUser = true;
        description = "nixPi";
        uid = 1003;
        group = "nixPi";
        extraGroups = [ "wheel" ];
      };
      adam.isNormalUser = true;
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEVI2t6BAIW6rjeSmsdEWxoJO7vyjYk+Gw5RsUGJAfhc adam@adam-nixos"
        ];
      };
    };
    groups = {
      nixPi = { };
    };
  };

  # nixos-raspberrypi options
  system.nixos.tags =
    let
      cfg = config.boot.loader.raspberryPi;
    in
    [
      "raspberry-pi-${cfg.variant}"
      cfg.bootloader
      config.boot.kernelPackages.kernel.version
    ];

  # Boot Options
  /*
    boot = {
      loader = {
        timeout = 5;
      };
      kernelPackages = pkgs.linuxPackages_latest;
      kernelParams = [
        "snd_bcm2835.enable_hdmi=1"
        "snd_bcm2835.enable_headphones=1"
      ];
    };
  */

  /*
    #Bluetooth on Pi4
    systemd.services.btattach = {
      before = [ "bluetooth.service" ];
      after = [ "dev-ttyAMA0.device" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = "${pkgs.bluez}/bin/btattach -B /dev/ttyAMA0 -P bcm -S 3000000";
      };
    };
  */

  services = {
    openssh = {
      enable = true;
      knownHosts = {
        adam-nixos = {
          publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEVI2t6BAIW6rjeSmsdEWxoJO7vyjYk+Gw5RsUGJAfhc";
          hostNames = [
            "adam@adam-nixos"
            "192.168.50.143"
          ];
        };
      };
      settings.PermitRootLogin = "yes";
    };
  };

  programs.git.config = {
    init.defaultBranch = "main";
    safe.directory = "/home/flake";
    user.name = "adam-nixPi4";
    user.email = "adamlundrigan1@gmail.com";
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
