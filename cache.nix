{
  lib,
  pkgs,
  ...
}:

{
  # Add cache
  nix.settings = {
    substituters = [ ];
    trusted-public-keys = [ ];
  };
}
