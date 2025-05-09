{
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
      what = "10.20.20.1:/mnt/M2/user/alphas";
      where = "/mnt/web-2xl/dump";
    }
  ];

  systemd.automounts = [
    {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "5";
      };
      where = "/mnt/web-2xl/dump";
    }
  ];
}
