{
  description = "NixOS";

  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-nstbl.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-25-05.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-24-11.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-23-11.url = "github:nixos/nixpkgs/nixos-23.11";

    # aagl-gtk-on-nix
    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-24.11";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Index
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs-nstbl,
      nixpkgs-25-05,
      nixpkgs-24-11,
      nixpkgs-24-05,
      nixpkgs-23-11,
      aagl,
      home-manager,
      nix-index-database,
      ...
    }:
    let
      overlays = [
        (final: prev: {
          unstable = import nixpkgs-nstbl {
            inherit (final) system;
            config.allowUnfree = true;
          };
        })
        (final: prev: {
          nix25-05 = import nixpkgs-25-05 {
            inherit (final) system;
            config.allowUnfree = true;
          };
        })
        (final: prev: {
          nix24-11 = import nixpkgs-24-11 {
            inherit (final) system;
            config.allowUnfree = true;
          };
        })
        (final: prev: {
          nix24-05 = import nixpkgs-24-05 {
            inherit (final) system;
            config.allowUnfree = true;
          };
        })
        (final: prev: {
          nix23-11 = import nixpkgs-23-11 {
            inherit (final) system;
            config.allowUnfree = true;
          };
        })
      ];

      getConfig = configFile: import configFile { inherit pkgs lib; };
      config = getConfig ./config.nix;

      configName = config.system.configurationName;
      hostname = config.system.configurationName;
      nixosVersion = config.system.nixosVersion;
      stateVersion = if nixosVersion == "unstable" then "25.05" else nixosVersion;

      nixpkgs =
        if nixosVersion == "unstable" then
          inputs.nixpkgs-nstbl
        else if nixosVersion == "25.05" then
          inputs.nixpkgs-25-05
        else if nixosVersion == "24.11" then
          inputs.nixpkgs-24-11
        else if nixosVersion == "24.05" then
          inputs.nixpkgs-24-05
        else if nixosVersion == "23.11" then
          inputs.nixpkgs-23-11
        else
          throw "Unsupported NixOS version: ${nixosVersion}";

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib;

      getUsersConfigs =
        configDir:
        let
          users = builtins.attrNames (builtins.readDir configDir);
        in
        builtins.listToAttrs (
          map (userName: {
            name = "${userName}";
            value = import "${configDir}/${userName}/home.nix";
          }) users
        );

      userConfigs = getUsersConfigs ./hosts/${configName}/2home/users;
    in
    {
      nixosConfigurations = {
        ${configName} = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit
              overlays
              inputs
              ;
          };
          modules = [
            # Add caching
            ./cache.nix
            ./hosts/${configName}/configuration.nix

            # nix-index-database (nix-locate)
            nix-index-database.nixosModules.nix-index
            # Home Manager module with common settings
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit
                  inputs
                  stateVersion
                  ;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # Creating home-manager for every user
              home-manager.users = lib.mkMerge [ userConfigs ];
            }

            {
              imports = [ aagl.nixosModules.default ];
              aagl.enableNixpkgsReleaseBranchCheck = false;
            }

            # Configuration
            {
              networking.hostName = hostname;
              system.stateVersion = stateVersion;
              nix.settings.experimental-features = [
                "nix-command"
                "flakes"
              ];
              # For adding yonix to path and custom bins in your path
              environment.localBinInPath = true;
            }
          ];
        };
      };
    };
}
