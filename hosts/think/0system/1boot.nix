{ config
, lib
, pkgs
, modulesPath
, ...
}:
{
  ## Boot
  # Initrd (First modules to load when starting linux)
  boot.initrd = {
    availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    kernelModules = [ ];
    luks.devices."luks-9bb15fbb-1cf8-4ac4-8776-1e260a456f31".device = "/dev/disk/by-uuid/9bb15fbb-1cf8-4ac4-8776-1e260a456f31";
  };
  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot = {
    kernelModules = [
      "kvm-intel"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };
}
