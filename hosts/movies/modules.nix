{ ... }:

{
  system.headless = true;
  system.nix-tree = true;
  system.podman = true;
  system.git = true;
  system.branch = "server";
  system.tailscale = {
    enable = true;
    server = true;
  };
}
