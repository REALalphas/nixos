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
      "xhci_pci"
      "ahci"
      "uas"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];
    kernelModules = [ ];
  };
  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  boot.kernelPackages = pkgs.linuxPackages_xanmod_stable;
  boot = {
    kernel.sysctl = {
      "vm.max_map_count" = 16777216;
      "fs.file-max" = 524288;
    };
    kernelParams = [
      # No poop on screen
      "quiet"
      "loglevel=3"
      # Poop screen
      "splash"
      # Skip CPU randomization check (speeds up boot)
      "random.trust_cpu=on"
      # Disable security mitigations (speeds up boot)
      "mitigations=off"
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
      # AMD KVM Support
      # "kvm-amd"
      # Intel KVM Support
      "kvm-intel"
      "v4l2loopback"
    ];
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };
  # Store temporary files in memory
  boot.tmp.useTmpfs = true;
  boot.tmp.tmpfsSize = "50%"; # RAM volume to use
}
