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

  # AMD CPU Microcode
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Unsupported GPU Processing Mode / Davinci Resolve
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };
}
