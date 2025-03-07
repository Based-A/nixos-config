{
  description = "Flake 2.0";

  inputs = {
    #Core
    nixpkgs = { #Nixpkgs
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
    home-manager = { #Home-manager
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = { #Secrets management
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Customization
    stylix = { #Unify colour schemes
      url = "github:danth/stylix";
    };
    plasma-manager = { #Home-manager options for Plasma6 DE
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    #Applications
    blender-LTS = { #Static Blender versions
      url = "github:edolstra/nix-warez?dir=blender";
    };
    ghostty = { #Super cool terminal emulator
      url = "github:ghostty-org/ghostty";
    };

    #Infrastructure
    disko = { #Declarative Disk Management
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware = { #Pi4 Hardware Options
      url = "github:NixOS/nixos-hardware/master";
    };
    nix-ld = { #Run unpatched dynamically linked binaries
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = { #Secure Boot
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      stylix,
      plasma-manager,
      blender-LTS,
      ghostty,
      disko,
      nixos-hardware,
      nix-ld,
      lanzaboote,
      ...
    }@inputs:

    let
      x86_64 = "x86_64-linux";
      aarch64 = "aarch64-linux";
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        # Main Workstation
        adam =
          let
            host = "adam";
            system = x86_64;
          in
          lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit
                inputs
                host
                ;
            };
            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/nixos
              inputs.sops-nix.nixosModules.sops
            ];
          };

        # Laptop
        lilith =
          let
            host = "lilith";
            system = x86_64;
          in
          lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit
                inputs
                host
                ;
            };
            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/nixos
              inputs.sops-nix.nixosModules.sops
            ];
          };

        # macOS VM
        sachiel =
          let
            host = "sachiel";
            system = x86_64;
          in
          lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit
                inputs
                host
                ;
            };
            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/nixos
              inputs.sops-nix.nixosModules.sops
              inputs.disko.nixosModules.disko
            ];
          };

        # Home Assistant PC
        shamshel =
          let
            host = "shamshel";
            system = aarch64;
          in
          lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit 
                inputs
                host;
            };
            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/nixos
              inputs.sops-nix.nixosModules.sops
              inputs.disko.nixosModules.disko
              inputs.nixos-hardware.nixosModules.raspberry-pi-4
            ];
          };
      };

      homeConfigurations = {
        Adam = 
          let
            system = x86_64;
            user = "adam";
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit 
                inputs
                pkgs
                user
                ;
            };
            modules = [
              ./users/${user}/home.nix
              inputs.plasma-manager.homeManagerModules.plasma-manager
              inputs.stylix.homeManagerModules.stylix
            ];
          };

        Guest = 
          let
            system = x86_64;
            user = "guest";
            pkgs = import nixpkgs {
              inherit system;
              config.allowUnfree = true;
            };
          in
          home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit 
                inputs
                pkgs
                user
                ;
            };
            modules = [
              ./users/${user}/home.nix
              inputs.plasma-manager.homeManagerModules.plasma-manager              
            ];
          };
      };
    };
}
