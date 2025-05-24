{
  config,
  lib,
  ...
}:

let
  cfg = config.system.tailscale;
in
{
  options.system.tailscale = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable Tailscale service (VPN through Internet)";
  };

  config = lib.mkIf cfg {
    services.tailscale.enable = true;
    services.tailscale.useRoutingFeatures = "server";
  };
}
