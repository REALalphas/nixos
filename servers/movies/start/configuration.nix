{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/f8d11b47-22e0-4fcd-b877-5c7f85a00c2e";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/20F8-9A78";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
}
