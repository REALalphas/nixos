{ ... }:

{
  imports = [
    ./start
    # Run user settings before loading modules
    ./modules.nix
    ./custom
  ];
}
