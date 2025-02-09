{ config
, lib
, pkgs
, modulesPath
, ...
}:
{
  fileSystems = {
    "/" =
      {
        device = "/dev/disk/by-uuid/49bd5c79-52bd-43bc-b20f-7ba70502bae9";
        fsType = "btrfs";
        options = [ "subvol=@" ];
      };
    "/boot" =
      {
        device = "/dev/disk/by-uuid/B1AE-26E6";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };
    "/home" =
      {
        device = "/dev/disk/by-uuid/4068593f-6a2a-4b81-9517-1d2231d4780d";
        fsType = "btrfs";
      };
  };

  swapDevices = [ ];

}