{ config
, pkgs
, ...
}:
{
  # Mount web-2xl NFS share # See 12packages.nix # See 10services.nix
  systemd.mounts = [
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      # TODO: Set IP for web-2xl
      what = "192.168.2.3:/mnt/M1/user/alphas";
      where = "/mnt/web-2xl/alphas";
    }
  ];

  systemd.automounts = [
    {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/mnt/web-2xl/alphas";
    }
  ];
}
