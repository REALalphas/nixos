{
  config,
  pkgs,
  ...
}:
{
  # Mount web-2xl NFS share # See 12packages.nix # See 10services.nix
  systemd.mounts = [
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
      };
      what = "web.xl:/mnt/M1/user/alphas";
      where = "/mnt/web-2xl/alphas";
    }
    {
      type = "nfs";
      mountConfig = {
        Options = "noatime";
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
      where = "/mnt/web-2xl/alphas";
    }
    {
      wantedBy = [ "multi-user.target" ];
      automountConfig = {
        TimeoutIdleSec = "600";
      };
      where = "/mnt/web-2xl/dump";
    }
  ];

  # LACT (Linux AMDGPU Controller) # See 12packages.nix
  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = [ "multi-user.target" ];

  # Flatpak for users support # See 10services.nix
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
