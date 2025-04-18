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
    nix-alien = { #Run unpatched dynamically linked binaries
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Infrastructure
    disko = { #Declarative Disk Management
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
    };
  };
/* TODO:
  Add Components:
    nix-on-droid configuration
*/
  outputs = {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    stylix,
    plasma-manager,
    blender-LTS,
    disko,
    nix-alien,
    deploy-rs,
    ...
  }@inputs:

  let
    x86_64 = "x86_64-linux";
    aarch64 = "aarch64-linux";
    lib = nixpkgs.lib;
  in
  {
    # NixOS Host Machines
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
              lib
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
              lib
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
      ## This is where I'd put my working NixOS config for my Raspberry Pi,
      ## IF IT ACTUALLY WANTED TO WORK
      ### (It stays on Raspberry Pi OS for now)
      shamshel = {};
      # Home Server
      ramiel = 
        let 
          host = "ramiel";
          system = x86_64;
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
          ];
        };
    };
    # Home-manager Profiles
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
    # Deploy-rs
    deploy = {
      nodes = {
        lilith.profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.lilith;
        };
        sachiel.profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.sachiel;
        };
        shamshel.profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.aarch64-linux.activate.nixos self.nixosConfigurations.shamshel;
        };
        ramiel.profiles.system = {
          user = "root";
          path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.ramiel;
        };
      };
    };

    checks = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;
  };
}
