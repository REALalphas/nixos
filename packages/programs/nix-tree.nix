{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.system.nix-tree;
in
{
  options.system.nix-tree = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Nix tree for managing NixOS configurations";
  };

  config = lib.mkIf cfg {
    environment.systemPackages = [
      pkgs.nix-tree
    ];
  };
}
