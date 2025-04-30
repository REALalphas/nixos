{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./start
    # Run user settings before loading modules
    ./modules.nix
    ./packages
    ./custom
  ];
}
