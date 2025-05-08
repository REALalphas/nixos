{ ... }:
{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/579f330c-d694-4809-aa50-fc8f486af63f";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/0378-6789";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [ { device = "/dev/disk/by-uuid/d6728ffc-0927-4026-8dac-663d1e6bf158"; } ];
}
