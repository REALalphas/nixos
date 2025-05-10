{
  config,
  lib,
  ...
}:

let
  cfg = config.system.podman;
in
{
  options.system.podman = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable podman service/socket";
  };

  config = lib.mkIf cfg {
    # Enable common container config files in /etc/containers
    virtualisation.containers.enable = true;
    virtualisation.oci-containers.backend = "podman";
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
    };
    virtualisation.podman.defaultNetwork.settings.dns_enabled = true;
  };
}
