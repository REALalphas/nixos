{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # OpenTabletDriver
  hardware.opentabletdriver.enable = true;

  # AMD CPU Microcode
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Unsupported GPU Processing Mode / Davinci Resolve
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  # # Enable amdvlk driver
  # hardware.amdgpu.amdvlk.enable = true;
  # # OpenCL support (ROCm)
  # hardware.amdgpu.opencl.enable = true;

  # Support for i2c devices (required for ddcutil and add user to "i2c" group)
  hardware.i2c.enable = true;
}
