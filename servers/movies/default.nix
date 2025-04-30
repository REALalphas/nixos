{
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./start
    ./packages
    ./custom
  ];
}
