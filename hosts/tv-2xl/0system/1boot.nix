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
    availableKernelModules = [ "xhci_pci" "nvme" "ahci" "usbhid" "uas" "sd_mod" ];
    kernelModules = [ "kvm-amd" ];
  };
  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot = {
    kernel.sysctl = {
      "vm.max_map_count" = 16777216;
      "fs.file-max" = 524288;
    };
    kernelParams = [
      # GPU Passthrough
      # "amd_iommu=on"
      # "iommu=pt"
      # "vfio-pci.ids=1002:67df,1002:aaf0"

      # Waydroid
      "psi=1"
    ];
    kernelModules = [
      # GPU Passthrough
      # "vfio"
      # "vfio_iommu_type1"
      # "vfio_pci"
      # "vfio_virqfd"
      # KVM Support
      "kvm-amd"
      "v4l2loopback"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };
}
