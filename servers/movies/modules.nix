{
  config,
  pkgs,
  ...
}:

{
  system.headless = false;
  system.nix-tree = true;
  system.sonarr = true;
  system.radarr = true;
  system.git = true;
}
