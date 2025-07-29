{
  config,
  lib,
  ...
}:

let
  cfg = config.system.amd;
  kernelVer = config.boot.kernelPackages.kernel.version;
in
{
  options.system.amd = {
    description = "AMD CPU additional configuration";

    kernel = {
      zenpower = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable AMD CPU advanced temperature reading on Zen CPUs";
      };
      pstate = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable AMD CPU power scaling for eficiency and more performance on newer CPUs";
      };
    };
    microcode = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable AMD CPU Microcode update";
    };
    enableKVM = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable AMD CPU KVM hardware acceleration";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.microcode {
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    })
    (lib.mkIf cfg.enableKVM {
      boot.kernelModules = [ "kvm-amd" ];
    })
    (lib.mkIf cfg.kernel.pstate {
      # Thanks to https://github.com/NixOS/nixos-hardware/blob/master/common/cpu/amd/pstate.nix
      boot = lib.mkMerge [
        (lib.mkIf ((lib.versionAtLeast kernelVer "5.17") && (lib.versionOlder kernelVer "6.1")) {
          kernelParams = [ "initcall_blacklist=acpi_cpufreq_init" ];
          kernelModules = [ "amd-pstate" ];
        })
        (lib.mkIf ((lib.versionAtLeast kernelVer "6.1") && (lib.versionOlder kernelVer "6.3")) {
          kernelParams = [ "amd_pstate=passive" ];
        })
        (lib.mkIf (lib.versionAtLeast kernelVer "6.3") {
          kernelParams = [ "amd_pstate=active" ];
        })
      ];
    })
    (lib.mkIf cfg.kernel.zenpower {
      boot.blacklistedKernelModules = [ "k10temp" ];
      boot.extraModulePackages = [ config.boot.kernelPackages.zenpower ];
      boot.kernelModules = [ "zenpower" ];
    })
  ];
}
