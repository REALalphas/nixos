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
  hardware.opentabletdriver.enable = true;

  # Intel CPU Microcode
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  
  # Unsupported GPU Processing Mode / Davinci Resolve
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [ ];
  };
}
