{
  description = "Flake 2.0";

  inputs = {
    #Core
    nixpkgs = {
      # Nixpkgs
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    sops-nix = {
      # Secrets management
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Applications
    blender-LTS = {
      # Static Blender versions
      url = "github:edolstra/nix-warez?dir=blender";
    };
    nix-alien = {
      # Run unpatched dynamically linked binaries
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #Infrastructure
    disko = {
      # Declarative Disk Management
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
    };
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      sops-nix,
      blender-LTS,
      disko,
      nix-alien,
      deploy-rs,
      nixos-hardware,
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
        # Desktop
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
              ./modules
              inputs.sops-nix.nixosModules.sops
            ];
          };
        # Framework 13 Laptop
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
              ./modules
              inputs.sops-nix.nixosModules.sops
              inputs.disko.nixosModules.disko
              inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
            ];
          };
        # HP 250 G3 Notebook (macOS VM)
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
              ./modules
              inputs.sops-nix.nixosModules.sops
              inputs.disko.nixosModules.disko
            ];
          };
        # Raspberry Pi 4
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
                lib
                host
                ;
            };
            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/nixos
              inputs.sops-nix.nixosModules.sops
              inputs.disko.nixosModules.disko
              inputs.nixos-hardware.nixosModules.raspberry-pi-4
            ];
          };
        # Dell PowerEdge R710
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
                lib
                host
                ;
            };
            modules = [
              ./hosts/${host}/configuration.nix
              ./modules
              inputs.sops-nix.nixosModules.sops
              inputs.disko.nixosModules.disko
            ];
          };
        # Thinkpad T560 (Media Center)
        gaghiel =
          let
            host = "gaghiel";
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
              ./modules
              inputs.sops-nix.nixosModules.sops
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
          gaghiel.profiles.system = {
            user = "root";
            path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.gaghiel;
          };
        };
      };

      checks = builtins.mapAttrs (
        system: deployLib: deployLib.deployChecks self.deploy
      ) inputs.deploy-rs.lib;
    };
}
