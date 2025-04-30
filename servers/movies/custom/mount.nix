{
  config,
  pkgs,
  ...
}:

{
  boot.supportedFilesystems = [ "nfs" ];
  services.rpcbind.enable = true;

  environment.systemPackages = [
    pkgs.nfs-utils
  ];
  systemd.mounts = [
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime,noac,actimeo=3";
      };
      what = "web.xl:/mnt/M2/user/alphas";
      where = "/mnt/web-2xl/dump";
    }
  ];

  systemd.automounts = [
    {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/mnt/web-2xl/dump";
    }
  ];
}
