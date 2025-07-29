{
  config,
  lib,
  ...
}:

let
  cfg = config.system.tailscale;
in
{
  options.system.tailscale = {
    description = "Tailscale client daemon";

    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable Tailscale client daemon";
    };
    server = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable IP Forwarding and exit node mode";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.tailscale.enable = true;
    })
    (lib.mkIf cfg.server {
      services.tailscale.useRoutingFeatures = "server";
    })
  ];
}
