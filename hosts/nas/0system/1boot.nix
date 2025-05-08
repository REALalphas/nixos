{
  config,
  pkgs,
  ...
}:
{
  ## Boot
  # Initrd (First modules to load when starting linux)
  boot.initrd = {
    availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    kernelModules = [ ];
  };
  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  # # Supported Filesystems
  # boot.supportedFilesystems = [ "ntfs" ];
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;
  boot = {
    kernel.sysctl = {
      # Pressure to clean inodes and dentries in cache
      "vm.vfs_cache_pressure" = 50;
      # Make early write
      "vm.dirty_ratio" = 20;
      # Start early write
      "vm.dirty_background_ratio" = 10;
      # Expire cache fast
      "vm.dirty_expire_centisecs" = 4000;
      # Make kernel very aggressive
      "vm.overcommit_memory" = 2;
      "vm.overcommit_ratio" = 95;
      # Give more memory to the kernel space
      "vm.min_free_kbytes" = 131072; # 128MB
      # Give more processes to the system
      "vm.max_map_count" = 16777216;
      # Give more file descriptors to the system
      "fs.file-max" = 524288;
    };
    kernelParams = [
      # No poop on screen
      "quiet"
      # Poop screen
      "splash"
      # GPU Passthrough
      # "amd_iommu=on"
      # "iommu=pt"
      # "vfio-pci.ids=1002:67df,1002:aaf0"
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
