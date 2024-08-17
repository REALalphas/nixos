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
    availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
    kernelModules = [ ];
  };
  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot = {
    kernelModules = [
      "kvm-amd"
      "v4l2loopback"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };
}
