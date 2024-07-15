{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-2311.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";

    # An anime game launcher
    aagl = {
      # url = "github:ezKEa/aagl-gtk-on-nix";
      url = "github:ezKEa/aagl-gtk-on-nix/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-2311, nixpkgs-unstable, nixos-unstable, aagl, home-manager, ... }:
    let
      overlay-unstable = (final: prev: {
        unstable = import nixpkgs-unstable {
          inherit (final) system;
          config.allowUnfree = true;
        };
      });
      overlay-2311 = (final: prev: {
        nixpkgs2311 = import nixpkgs-2311 {
          inherit (final) system;
          config.allowUnfree = true;
        };
      });
    in
    {
      nixosConfigurations = {
        nas-2xl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs overlay-unstable overlay-2311;
          };
          modules = [
            ./hosts/nas-2xl/configuration.nix
            ./hosts/nas-2xl/system/packages.nix

            # An anime game launcher
            {
              imports = [ aagl.nixosModules.default ];
              nix.settings = aagl.nixConfig; # Set up Cachix
              programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
              programs.sleepy-launcher.enable = true;
              # programs.anime-games-launcher.enable = true;
              # programs.anime-borb-launcher.enable = true;
              # programs.honkers-railway-launcher.enable = true;
              # programs.honkers-launcher.enable = true;
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.alphas = import ./hosts/nas-2xl/alphas/home.nix;
              home-manager.users.kaktus = import ./hosts/nas-2xl/kaktus/home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            }
          ];
        };
        think-2xl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs overlay-unstable overlay-2311;
          };
          modules = [
            ./hosts/think-2xl/configuration.nix
            ./hosts/think-2xl/system/packages.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              home-manager.users.alphas = import ./hosts/think-2xl/alphas/home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
            }
          ];
        };
      };
    };
}
