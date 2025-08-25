{ ... }:

{
  system.headless = true;
  system.podman = true;
  system.git = {
    enable = true;
    branch = "server";
  };
}
