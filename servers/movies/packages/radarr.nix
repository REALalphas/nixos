{
  config,
  lib,
  ...
}:

let
  cfg = config.system.radarr;
in
{
  options.system.radarr = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable Radarr service (a PVR for Usenet and BitTorrent users for movies)";
  };

  config = lib.mkIf cfg {
    # Enable Radarr service
    services.radarr = {
      enable = true;
      dataDir = "/mnt/web-2xl/dump/Media";
      user = "alphas";
    };
  };
}
