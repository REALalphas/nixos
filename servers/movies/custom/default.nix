{ ... }:
let
  dir = ./.;
  files = builtins.readDir dir;
  nixFiles = builtins.filter (
    name:
    (builtins.stringLength name >= 4)
    && (builtins.substring (builtins.stringLength name - 4) 4 name == ".nix")
    && name != "default.nix" # Exclude default.nix itself
  ) (builtins.attrNames files);
  imports = map (name: "${dir}/${name}") nixFiles;
in
{
  imports = imports;
}
# DO NOT TOUCH THIS FILE
# This file for generating imports
