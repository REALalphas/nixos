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
        device = "/dev/disk/by-uuid/b298c04d-f238-4104-b603-92ca5ce7374d";
        fsType = "ext4";
      };
    "/boot" =
      {
        device = "/dev/disk/by-uuid/08A5-4A7E";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/e795e760-bf1b-47ec-8196-364a94cb1f9d"; }
  ];

}
