{ lib
, pkgs
, ...
}:

{
  # Configuration name and hostname
  system.configurationName = "nas";
  # NixOS version
  system.nixosVersion = "24.11";
}
