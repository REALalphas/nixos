{
  config,
  pkgs,
  ...
}:

{
  system.headless = true;
  system.nix-tree = true;
}
