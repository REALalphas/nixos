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
        device = "/dev/disk/by-uuid/627fe10b-e788-4993-93be-6c5a00c248fa";
        fsType = "ext4";
      };
    "/boot" =
      {
        device = "/dev/disk/by-uuid/CE17-D585";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" ];
      };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/0d10dc57-6dda-4f09-8642-c5052a8ac2c4"; }
  ];

}