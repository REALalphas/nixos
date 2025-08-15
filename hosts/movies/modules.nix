{ ... }:

{
  system.headless = true;
  system.nix-tree = true;
  system.podman = true;
  system.git = {
    enable = true;
    branch = "server";
  };
  system.tailscale = {
    enable = true;
    server = true;
  };
}
