{
  config,
  lib,
  ...
}:

let
  cfg = config.system.nixarr;
in
{
  options.system.nixarr = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable nixarr services";
  };

  config = lib.mkIf cfg {
    nixarr = {
      enable = true;

      mediaDir = "/mnt/web-2xl/dump/Media";
      stateDir = "/mnt/web-2xl/dump/Media/.services";

      jellyfin = {
        enable = true;
        # expose.https = {
        #   enable = true;
        # };
      };

      bazarr.enable = true;
      lidarr.enable = true;
      prowlarr.enable = true;
      radarr.enable = true;
      readarr.enable = true;
      sonarr.enable = true;
      jellyseerr.enable = true;
    };
  };
}
