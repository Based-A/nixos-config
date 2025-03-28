{
  config,
  pkgs,
  lib,
  inputs,
  host,
  ...
}:

{
  # Main Workstation Computer
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
  nixLd.enable = true;
  nvidia-graphics.enable = true;

  ## Services
  podman.enable = true;
  sunshine.enable = true;
  nextcloud-server.enable = true;

  ## Other
  shellAliases.enable = true;

  ## Packages
  audio-apps.enable = true;
  digital-art.enable = true;

  ## Desktop Environments
  Plasma6.enable = true;

  #System Packages
  environment.systemPackages = with pkgs; [
    home-manager
    gpu-screen-recorder-gtk
    nvitop
    sourcegit
    lmstudio
    sbctl

    # Games
    #atlauncher
    itch
  ];

  sops = {
    defaultSopsFile = ./../../modules/secrets/secrets.json;
    defaultSopsFormat = "json";

    age.keyFile = "/nix/persist/sops/age/keys.txt";
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
    gamemode.enable = true;
    noisetorch.enable = true;
  };
  
  # Services
  services = {
    openssh.enable = true;
    flatpak.enable = true;
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    printing.enable = true;
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
    kernelPackages = pkgs.linuxPackages;
    supportedFilesystems = [ "ntfs" ];
  };

  # Mount Windows Partition
  fileSystems."/run/media/adam/Windows" = {
    device = "/dev/disk/by-uuid/06C81129C811188F";
    fsType = "ntfs";
    options = [
      "rw"
      "uid = 1000"
    ];
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
    BROWSER = "app.zen_browser.zen";
    TERM = "ghostty";
  };

  xdg.autostart.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
