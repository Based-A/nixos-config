{
  config,
  pkgs,
  inputs,
  host,
  ...
}:

{
  # macOS VirtualBox
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../modules
    inputs.sops-nix.nixosModules.sops
    ./${host}-disko-config.nix
  ];

  # Modules

  ## HardwareOptions
  file-cleanup.enable = true;

  ## Other
  shellAliases.enable = true;

  ## Desktop Environments
  Xfce.enable = true;

  #System Packages
  environment.systemPackages = with pkgs; [
    quickemu
    quickgui
    xterm
  ];

  sops = {
    defaultSopsFile = ./../../modules/secrets/secrets.json;
    defaultSopsFormat = "json";

    age.keyFile = "/nix/persist/sops/age/keys.txt";

    secrets.adam_ssh_key = {
      path = "/home/macOS/.ssh/id_ed25519";
      owner = config.users.users.macOS.name;
    };
  };

  users ={
    users = {
      macOS = {
        isNormalUser = true;
        description = "macOS VM";
        group = "macOS";
        uid = 1002;
        extraGroups = [ "wheel" ];
      };
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEVI2t6BAIW6rjeSmsdEWxoJO7vyjYk+Gw5RsUGJAfhc adam@adam-nixos"
        ];
      };
    };
    groups = {
      macOS = {};
    };
  };

#nix run github:nix-community/nixos-anywhere -- --flake ./home/flake#sachiel --generate-hardware-config nixos-generate-config ./hosts/sachiel/hardware-configuration.nix root@192.168.50.248
  #Git Config
  programs.git.config = {
    init.defaultBranch = "main";
    safe.directory = "/home/flake";
    user.name = "adam-macOSVM";
    user.email = "adamlundrigan1@gmail.com";
  };

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
    logind = {
      lidSwitch = "ignore";
    };
    upower = {
      enable = true;
      ignoreLid = true;
    };
  };

  # Boot Options
  boot = {
    loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
      };
    };
  };

  # Networking Options
  networking = {
    hostName = "sachiel-nixos"; # Define your hostname.
    networkmanager.enable = true; # Enable networking.
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    firewall.allowedUDPPorts = [
    ]; # Open ports in the firewall.
  };

  environment.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
    WAYFIRE_CONFIG_FILE = "/home/macOS/.config/wayfire.ini";
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
