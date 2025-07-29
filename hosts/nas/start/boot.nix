{
  config,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "ahci"
    "xhci_pci"
    "virtio_pci"
    "virtio_scsi"
    "nvme"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  # Enable kernel optimization
  boot.kernelParams = [
    "quiet"
    "systemd.show_status=0"
    "rd.udev.log_level=3"
  ];
  boot.kernel.sysctl = {
    # Pressure to clean inodes and dentries in cache
    "vm.vfs_cache_pressure" = 180;
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

  # AMD CPU
  # hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  # boot.kernelModules = [ "kvm-amd" ];

  # Intel CPU
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  boot.kernelModules = [ "kvm-intel" ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 5;
  };
}
