{ config
, lib
, pkgs
, modulesPath
, ...
}:
{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # OpenTabletDriver
  # hardware.opentabletdriver.enable = true;

  # AMD CPU Microcode
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Nvidia Drivers
  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;

    open = false;

    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      offload = {
        enable = true;  
        enableOffloadCmd = true;
      };

      # intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:5:0:0";
    };
  };
  
  # Unsupported GPU Processing Mode / Davinci Resolve
  hardware.graphics = {
    enable = true;
  };

  # Support for i2c devices (required for ddcutil and add user to "i2c" group)
  # hardware.i2c.enable = true;
}
