{
  pkgs,
  ...
}:
let
  containers = {
    recyclarr = {
      image = "ghcr.io/recyclarr/recyclarr";
      user = "1000";
      autoStart = true;
      ports = [];
      volumes = [
        "/mnt/web-2xl/dump/Media/.services/recyclarr:/config"
      ];
      environment = {
        TZ = "Europe/Moscow";
        RECYCLARR_CREATE_CONFIG = "true";
      };
      dependsOn = [ "sonarr-shows" "sonarr-anime" "radarr" ];
    };
    jellyfin = {
        image = "jellyfin/jellyfin";
        user = "1000";
        autoStart = true;
        ports = [
            "8096:8096"
            "8920:8920"
            "1900:1900"
            "7359:7359"
        ];
        volumes = [
            "/mnt/web-2xl/dump/Media/.services/jellyfin/config:/config"
            "/mnt/web-2xl/dump/Media/.services/jellyfin/cache:/cache"
            "/mnt/web-2xl/dump/Media:/media:ro"
        ];
        environment = {};
    };
    jellyseerr = {
        image = "ghcr.io/fallenbagel/jellyseerr";
        user = "1000";
        autoStart = true;
        ports = [ "5055:5055" ];
        volumes = [
          "/mnt/web-2xl/dump/Media/.services/jellyseerr:/app/config"
        ];
        environment = {
          TZ = "Europe/Moscow";
          LOG_LEVEL = "debug";
        };
        dependsOn = [ "jellyfin" ];
    };
    deluge = {
        image = "lscr.io/linuxserver/deluge";
        user = "1000";
        autoStart = true;
        ports = [
            "8112:8112"
            "6881:6881"
            "6881:6881/udp"
        ];
        volumes = [
          "/mnt/web-2xl/dump/Media/.services/deluge:/config"
          "/mnt/web-2xl/dump/Media/torrents:/downloads"
        ];
        environment = {
          TZ = "Europe/Moscow";
          PUID = "1000";
          PGID = "100";
        };
    };
    sonarr-shows = {
        image = "lscr.io/linuxserver/sonarr";
        user = "1000";
        autoStart = true;
        ports = [ "8989:8989" ];
        volumes = [
          "/mnt/web-2xl/dump/Media/.services/sonarr-shows:/config"
          "/mnt/web-2xl/dump/Media/tv:/tv"
          "/mnt/web-2xl/dump/Media/torrents/tv:/downloads"
        ];
        environment = {
          TZ = "Europe/Moscow";
          PUID = "1000";
          PGID = "100";
        };
    };
    sonarr-anime = {
        image = "lscr.io/linuxserver/sonarr";
        user = "1000";
        autoStart = true;
        ports = [ "8990:8989" ];
        volumes = [
          "/mnt/web-2xl/dump/Media/.services/sonarr-anime:/config"
          "/mnt/web-2xl/dump/Media/anime:/anime"
          "/mnt/web-2xl/dump/Media/torrents/anime:/downloads"
        ];
        environment = {
          TZ = "Europe/Moscow";
          PUID = "1000";
          PGID = "100";
        };
    };
    radarr = {
        image = "lscr.io/linuxserver/radarr";
        user = "1000";
        autoStart = true;
        ports = [ "7878:7878" ];
        volumes = [
          "/mnt/web-2xl/dump/Media/.services/radarr:/config"
          "/mnt/web-2xl/dump/Media/movies:/movies"
          "/mnt/web-2xl/dump/Media/torrents/movies:/downloads"
        ];
        environment = {
          TZ = "Europe/Moscow";
          PUID = "1000";
          PGID = "100";
        };
    };
    prowlarr = {
        image = "lscr.io/linuxserver/prowlarr";
        user = "1000";
        autoStart = true;
        ports = [ "9696:9696" ];
        volumes = [
          "/mnt/web-2xl/dump/Media/.services/prowlarr:/config"
        ];
        environment = {
          TZ = "Europe/Moscow";
          PUID = "1000";
          PGID = "100";
        };
    };
  };
in
{
  virtualisation.oci-containers.containers = containers;
}
