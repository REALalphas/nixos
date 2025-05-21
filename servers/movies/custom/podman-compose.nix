{ ... }:
let
  _ = { };

  # Torrent Client
  _.deluge = {
    image = "lscr.io/linuxserver/deluge";
    ports = [
      "8112:8112"
      "6881:6881"
      "6881:6881/udp"
      "58846:58846"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/deluge:/config"
      "/mnt/web-2xl/dump/Media/data/torrents:/data/torrents"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
      DELUGE_LOGLEVEL = "error";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
    # extraOptions = [ "--network=host" ];
  };
  # Torrent Client
  _.qbittorrent = {
    image = "lscr.io/linuxserver/qbittorrent";
    ports = [
      # "8080:8080"
      # "6882:6882"
      # "6882:6882/udp"
      # "7656:7656"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/qbittorrent:/config"
      "/mnt/web-2xl/dump/Media/data/torrents:/data/torrents"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
      WEBUI_PORT = "8080";
      TORRENTING_PORT = "6882";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
    extraOptions = [ "--network=host" ];
  };
  # Usenet Client
  _.nzbget = {
    image = "nzbgetcom/nzbget";
    ports = [
      "6789:6789"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/nzbget:/config"
      "/mnt/web-2xl/dump/Media/data/usenet:/data/usenet"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
      NZBGET_USER = "nzbget";
      NZBGET_PASS = "vxa3zywg";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
    # extraOptions = [ "--network=host" ];
  };
  # Soulseek Client
  _.slskd = {
    image = "slskd/slskd";
    ports = [
      "5030:5030"
      "5031:5031"
      "50300:50300"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/slskd:/app"
      "/mnt/web-2xl/dump/Media/data/slskd:/data/slskd"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
      SLSKD_REMOTE_CONFIGURATION = "true";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
  };
  # Sync Manager from Lidarr to slskd
  _.soularr = {
    image = "mrusse08/soularr";
    ports = [ ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/soularr:/data"
      "/mnt/web-2xl/dump/Media/data/slskd/downloaded:/data/slskd/downloaded"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
      SCRIPT_INTERVAL = "300";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
  };
  # Shows Manager
  _.sonarr = {
    image = "lscr.io/linuxserver/sonarr";
    ports = [
      "8989:8989"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/sonarr:/config"
      "/mnt/web-2xl/dump/Media/data:/data"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
    };
    dependsOn = [ "qbittorrent" ];
    user = "1000";
    autoStart = true;
  };
  # Movies Manager
  _.radarr = {
    image = "lscr.io/linuxserver/radarr";
    ports = [
      "7878:7878"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/radarr:/config"
      "/mnt/web-2xl/dump/Media/data:/data"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
    };
    dependsOn = [ "qbittorrent" ];
    user = "1000";
    autoStart = true;
  };
  # Music Manager
  _.lidarr = {
    image = "lscr.io/linuxserver/lidarr";
    ports = [
      "8686:8686"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/lidarr:/config"
      "/mnt/web-2xl/dump/Media/data:/data"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
    };
    dependsOn = [ "qbittorrent" ];
    user = "1000";
    autoStart = true;
  };
  # Config for Sonarr/Radarr Manager
  _.recyclarr = {
    image = "ghcr.io/recyclarr/recyclarr";
    ports = [ ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/recyclarr:/config"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
      RECYCLARR_CREATE_CONFIG = "true";
    };
    dependsOn = [
      "sonarr"
      "radarr"
    ];
    user = "1000";
    autoStart = true;
  };
  # Indexer of Torrent and Usenet Trackers (Bigger listing)
  _.jackett = {
    image = "lscr.io/linuxserver/jackett";
    ports = [
      "9117:9117"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/jackett:/config"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
      AUTO_UPDATE = "true";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
  };
  # Indexer of indexers and autosetup
  _.prowlarr = {
    image = "lscr.io/linuxserver/prowlarr";
    ports = [
      "9696:9696"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/prowlarr:/config"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
  };
  # Dashboard to request media
  _.jellyseerr = {
    image = "fallenbagel/jellyseerr";
    ports = [
      "5055:5055"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/jellyseerr:/app/config"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
      LOG_LEVEL = "debug";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
  };
  # Dashboard to watch media
  _.jellyfin = {
    image = "jellyfin/jellyfin";
    ports = [ ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/jellyfin:/config"
      "/mnt/web-2xl/dump/Media/config/jellyfin-cache:/cache"
      "/mnt/web-2xl/dump/Media/data/media:/data/media:ro"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
      LOG_LEVEL = "debug";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
    extraOptions = [ "--network=host" ];
  };
  # Music streaming
  _.navidrome = {
    image = "deluan/navidrome";
    ports = [
      "4533:4533"
    ];
    volumes = [
      "/mnt/web-2xl/dump/Media/config/navidrome:/data"
      "/mnt/web-2xl/dump/Media/data/media/music:/music:ro"
    ];
    environment = {
      PUID = "1000";
      PGID = "100";
      TZ = "Europe/Moscow";
      ND_LOGLEVEL = "debug";
    };
    dependsOn = [ ];
    user = "1000";
    autoStart = true;
  };
in
{
  virtualisation.oci-containers.containers = _;
}
