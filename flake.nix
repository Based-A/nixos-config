{
  description = "Flake 2.0";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs?ref=nixos-unstable";
#      follows = "nixos-cosmic/nixpkgs"; COSMIC doesn't build, will enable when it works.
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    blender-LTS.url = "github:edolstra/nix-warez?dir=blender";

    ghostty.url = "github:ghostty-org/ghostty";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #nixos-cosmic.url  = "github:lilyinstarlight/nixos-cosmic"; #COSMIC doesn't build, will enable when it works.

    #cosmic-manager = {
    #  url = "github:HeitorAugustoLN/cosmic-manager"; #COSMIC doesn't build, will enable when it works.
    #  inputs = {
    #    nixpkgs.follows = "nixpkgs";
    #    home-manager.follows = "home-manager";
    #  };
    #};
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      plasma-manager,
      blender-LTS,
      ghostty,
      sops-nix,
      #nixos-cosmic, #COSMIC
      #cosmic-manager, #COSMIC
      ...
    }@inputs:

    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        #overlays = [ nixos-cosmic.overlays.default ] ; #COSMIC
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;

    in
    {
      nixosConfigurations = {
        # Main Workstation
        adam =
          let
            host = "adam";
          in
          lib.nixosSystem {
            inherit system;

            specialArgs = {
              inherit
                pkgs
                inputs
                host
                ;
            };

            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/nixos
              inputs.sops-nix.nixosModules.sops
              #inputs.nixos-cosmic.nixosModules.default # COSMIC
            ];
          };

        # Laptop
        lilith =
          let
            host = "lilith";
          in
          lib.nixosSystem {
            # This is a x86_64 system
            inherit system;

            specialArgs = {
              inherit
                inputs
                pkgs
                host
                ;
            };

            # Using these nix modules
            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/nixos
              inputs.sops-nix.nixosModules.sops
              #inputs.nixos-cosmic.nixosModules.default # COSMIC
            ];
          };

        # Home Server
        sachiel =
          let
            host = "sachiel";
          in
          lib.nixosSystem {
            inherit system;

            specialArgs = {
              inherit
                inputs
                pkgs
                host
                ;
            };

            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/nixos
              sops-nix.nixosModules.sops
            ];
          };

        # Home Assistant PC
        shamshel =
          let
            host = "shamshel";
          in
          lib.nixosSystem {
            inherit system;

            specialArgs = {
              inherit 
                inputs
                pkgs
                host;
            };

            modules = [
              ./hosts/${host}/configuration.nix
              ./modules/nixos
              sops-nix.nixosModules.sops
            ];
          };
      };

      homeConfigurations = {
        Adam = 
          let
            user = "Adam";
          in
          home-manager.lib.homeManagerConfiguration {
            inherit
              pkgs;
            
            extraSpecialArgs = {
              inherit 
                pkgs
                inputs
                user
                ;
            };

            modules = [
              ./users/${user}/home.nix

              inputs.plasma-manager.homeManagerModules.plasma-manager 
              #inputs.cosmic-manager.homeManagerModules.cosmic-manager               
            ];
          };

        Guest = 
          let
            user = "Guest";
          in
          home-manager.lib.homeManagerConfiguration {
            extraSpecialArgs = {
              inherit 
                pkgs
                inputs
                user
                ;
            };

            modules = [
              ./users/${user}/home.nix

              inputs.plasma-manager.homeManagerModules.plasma-manager 
              #inputs.cosmic-manager.homeManagerModules.cosmic-manager               
            ];
          };
      };
    };
}
