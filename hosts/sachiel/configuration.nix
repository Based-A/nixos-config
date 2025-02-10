{
  config,
  pkgs,
  inputs,
  ...
}:

{
  # macOS VirtualBox
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./../../modules/nixos
    inputs.sops-nix.nixosModules.sops
    ./../../diskoConfs/macOSVM-disk-config.nix
  ];

  # Modules

  ## HardwareOptions
  bluetooth.enable = false;
  file-cleanup.enable = true;
  nvidia-graphics.enable = false;
  power-management.enable = false;

  ## Services
  docker.enable = false;
  home-assistant.enable = false;
  plex.enable = false;
  podman.enable = false;
  sunshine.enable = false;

  ## Other
  shellAliases.enable = true;

  ## Desktop Environments
  Plasma6.enable = false;
  #CosmicDE.enable = true;
  XfceWayfire.enable = true;

  #System Packages
  environment.systemPackages = with pkgs; [
    quickemu
    quickgui
  ];

  #Accepted Remote SSH Keys
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEVI2t6BAIW6rjeSmsdEWxoJO7vyjYk+Gw5RsUGJAfhc adam@adam-nixos"
  ];
#nix run github:nix-community/nixos-anywhere -- --flake ./home/flake#sachiel --generate-hardware-config nixos-generate-config ./hosts/sachiel/hardware-configuration.nix root@192.168.50.248
  #Git Config
  programs.git.config = {
    init.defaultBranch = "main";
    safe.directory = "home/flake";
    user.name = "adam-macOSVM";
    user.email = "adamlundrigan1@gmail.com";
  };

  services = {
    openssh.enable = true;
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
  };

  system.stateVersion = "24.05"; # Did you read the comment?

}
