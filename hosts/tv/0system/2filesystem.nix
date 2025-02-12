{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
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

  swapDevices = [ { device = "/dev/disk/by-uuid/188be88b-bcaa-4a8a-a0c3-bc62d6f1886b"; } ];

}
