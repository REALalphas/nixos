{
  config,
  pkgs,
  ...
}:

{
  system.headless = true;
  system.nix-tree = true;
  system.sonarr = true;
  system.git = true;
}
