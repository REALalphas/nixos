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
      what = "web.xl:/mnt/M1/user/alphas";
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

  # LACT (Linux AMDGPU Controller) # See 12packages.nix
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];
}
