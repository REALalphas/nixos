{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.system.sonarr;
in
{
  options.system.sonarr = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable Sonarr service (a PVR for Usenet and BitTorrent users for TV shows)";
  };

  config = lib.mkIf cfg {
    # Enable Sonarr service
    services.sonarr = {
      enable = true;
      dataDir = "/mnt/web-2xl/dump/Media";
      user = "alphas";
    };
  };
}
