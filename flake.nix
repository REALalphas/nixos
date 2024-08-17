# {
#   description = "NixOS";

#   inputs = {
#     # nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
#     # nixpkgs-2311.url = "github:nixos/nixpkgs/nixos-23.11";
#     # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
#     # nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
#     # nix-gaming.url = "github:fufexan/nix-gaming";

#     # # An anime game launcher
#     # aagl = {
#     #   # url = "github:ezKEa/aagl-gtk-on-nix";
#     #   url = "github:ezKEa/aagl-gtk-on-nix/release-24.05";
#     #   inputs.nixpkgs.follows = "nixpkgs";
#     # };

#     # # home-manager, used for managing user configuration
#     # home-manager = {
#     #   url = "github:nix-community/home-manager/release-24.05";
#     #   inputs.nixpkgs.follows = "nixpkgs";
#     # };
#   };

#   outputs =
#     inputs@{ self
#     , nixpkgs
#     , nixpkgs-2311
#     , nixpkgs-unstable
#     , nixos-unstable
#     , aagl
#     , home-manager
#     , ...
#     }:
#     let
#       # overlay-unstable = (final: prev: {
#       #   unstable = import nixpkgs-unstable {
#       #     inherit (final) system;
#       #     config.allowUnfree = true;
#       #   };
#       # });
#       # overlay-2311 = (final: prev: {
#       #   nixpkgs2311 = import nixpkgs-2311 {
#       #     inherit (final) system;
#       #     config.allowUnfree = true;
#       #   };
#       # });

#       getUsersConfigs = configDir:
#         builtins.mapAttrs
#           (userName: _:
#             {
#               "home-manager.users.${userName}" = import "${configDir}/${userName}/home.nix";
#             }
#           )
#           (
#             builtins.attrNames (builtins.readDir configDir)
#           );
#     in
#     {
#       nixosConfigurations = {
#         configurationName = pkgs.lib.nixosSystem {
#           system = "x86_64-linux";
#           specialArgs = { inherit inputs; };
#           modules = [
#             ./hosts/{configurationName}/configuration.nix

#             home-manager.nixosModules.home-manager
#             {
#               home-manager.extraSpecialArgs = { inherit inputs; };
#               home-manager.useGlobalPkgs = true;
#               home-manager.useUserPackages = true;
#             }
#             (getUsersConfigs ./hosts/{configurationName}/2home)
#             # home-manager.nixosModules.home-manager
#             # (getUsersConfigs ./hosts/{configurationName})
#           ];
#         };
#         # nas-2xl = nixpkgs.lib.nixosSystem {
#         #   system = "x86_64-linux";
#         #   specialArgs = {
#         #     inherit inputs overlay-unstable overlay-2311;
#         #   };
#         #   modules = [
#         #     ./hosts/nas-2xl/configuration.nix
#         #     ./hosts/nas-2xl/system/packages.nix

#         #     # An anime game launcher
#         #     {
#         #       imports = [ aagl.nixosModules.default ];
#         #       nix.settings = aagl.nixConfig; # Set up Cachix
#         #       programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
#         #       programs.sleepy-launcher.enable = true;
#         #       # programs.anime-games-launcher.enable = true;
#         #       # programs.anime-borb-launcher.enable = true;
#         #       # programs.honkers-railway-launcher.enable = true;
#         #       # programs.honkers-launcher.enable = true;
#         #     }

#         #     home-manager.nixosModules.home-manager
#         #     {
#         #       home-manager.extraSpecialArgs = { inherit inputs; };

#         #       home-manager.useGlobalPkgs = true;
#         #       home-manager.useUserPackages = true;

#         #       home-manager.users.alphas = import ./hosts/nas-2xl/alphas/home.nix;
#         #       home-manager.users.kaktus = import ./hosts/nas-2xl/kaktus/home.nix;

#         #       # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
#         #     }
#         #   ];
#         # };
#         # think-2xl = nixpkgs.lib.nixosSystem {
#         #   system = "x86_64-linux";
#         #   specialArgs = {
#         #     inherit inputs overlay-unstable overlay-2311;
#         #   };
#         #   modules = [
#         #     ./hosts/think-2xl/configuration.nix
#         #     ./hosts/think-2xl/system/packages.nix

#         #     home-manager.nixosModules.home-manager
#         #     {
#         #       home-manager.extraSpecialArgs = { inherit inputs; };

#         #       home-manager.useGlobalPkgs = true;
#         #       home-manager.useUserPackages = true;

#         #       home-manager.users.alphas = import ./hosts/think-2xl/alphas/home.nix;

#         #       # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
#         #     }
#         #   ];
#         # };
#       };
#     };
# }
{
  description = "NixOS";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-nstbl.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-23-11.url = "github:nixos/nixpkgs/nixos-23.11";

    # Spicetify-Nix
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Gaming related stuff for Nix and NixOS
    nix-gaming.url = "github:fufexan/nix-gaming";

    # aagl-gtk-on-nix
    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-24.05";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs-nstbl
    , nixpkgs-24-05
    , nixpkgs-23-11
    , aagl
    , home-manager
    , ...
    }:
    let
      overlays = [
        (final: prev: {
          unstable = import nixpkgs-nstbl { inherit (final) system; config.allowUnfree = true; };
        })
        (final: prev: {
          nix24-05 = import nixpkgs-24-05 { inherit (final) system; config.allowUnfree = true; };
        })
        (final: prev: {
          nix23-11 = import nixpkgs-23-11 { inherit (final) system; config.allowUnfree = true; };
        })
      ];

      getConfig = configFile: import configFile { inherit pkgs lib; };
      config = getConfig ./config.nix;

      configName = config.system.configurationName;
      hostname = config.system.configurationName;
      nixosVersion = config.system.nixosVersion;
      stateVersion = config.system.nixosVersion;

      nixpkgs =
        if nixosVersion == "24.05" then inputs.nixpkgs-24-05
        else if nixosVersion == "23.11" then inputs.nixpkgs-23-11
        else throw "Unsupported NixOS version: ${nixosVersion}";

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib;

      getUsersConfigs = configDir:
        let
          users = builtins.attrNames (builtins.readDir configDir);
        in
        builtins.listToAttrs (map
          (userName: {
            name = "${userName}";
            value = import "${configDir}/${userName}/home.nix";
          })
          users);

      userConfigs = getUsersConfigs ./hosts/${configName}/2home/users;
    in
    {
      nixosConfigurations = {
        ${configName} = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              overlays
              inputs;
          };
          modules = [
            # Add caching
            ./cache.nix
            ./hosts/${configName}/configuration.nix

            # Home Manager module with common settings
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # Creating home-manager for every user
              home-manager.users = lib.mkMerge [ userConfigs ];
            }

            {
              imports = [ aagl.nixosModules.default ];
            }

            # Configuration
            {
              networking.hostName = hostname;
              system.stateVersion = stateVersion;
              nix.settings.experimental-features = [ "nix-command" "flakes" ];
            }
          ];
        };
      };
    };
}
