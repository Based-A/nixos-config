{
  config,
  pkgs,
  inputs,
  host,
  ...
}:

{
  # Laptop Light Workstation
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
  power-management.enable = false;

  ## Services
  podman.enable = true;

  ## Other
  shellAliases.enable = true;

  ## Desktop Environments
  Plasma6.enable = true;

  ## Packages
  digital-art.enable = true;

  environment.systemPackages = with pkgs; [
    home-manager
    moonlight-qt
    sourcegit
  ];

  sops = {
    defaultSopsFile = ./../../modules/secrets/secrets.json;
    defaultSopsFormat = "json";

    age.keyFile = "/nix/persist/sops/age/keys.txt";

    #secrets.adam_ssh_key = {
    #  path = "/home/adam/.ssh/id_ed25519";
    #  owner = config.users.users.adam.name;
    #};
  };

  users = {
    users = {
      adam = {
        isNormalUser = true;
        description = "adam";
        uid = 1000;
        group = "adam";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEVI2t6BAIW6rjeSmsdEWxoJO7vyjYk+Gw5RsUGJAfhc adam@adam-nixos"
        ];
      };
      guest = {
        isNormalUser = true;
        description = "guest profile";
        group = "guest";
        uid = 1001;
      };
    };
    groups = {
      adam = {};
      guest = {};
    };
  };

  # Programs
  programs = {
    firefox.enable = true;
    steam.enable = true;
  };
  
  # Services
  services = {
    openssh.enable = true;
    flatpak.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
    xserver = {
      videoDrivers = [ "intel" ];
    };
  };

  # Hardware
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime-legacy1
    ];
  };

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
  };

  # Networking Options
  networking = {
    hostName = "lilith-nixos"; # Define your hostname.
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
    BROWSER = "app.zen_browser.zen";
    TERM = "ghostty";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
