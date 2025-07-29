{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.system.amdgpu;
in
{
  options.system.amdgpu = {
    description = "AMD GPU additional configuration";

    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable AMD GPU graphics acceleration";
    };
    enable32Bit = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable 32Bit support for graphics acceleration";
    };
    enableHIP = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable HIP hard-code";
    };
    enableOpenCL = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable OpenCL setup";
    };
    enableAMDVLK = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to add install of AMD's Implementation of Vulkan";
    };
    enableAMDVLK32Bit = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to add install of AMD's Implementation of Vulkan (32Bit support)";
    };
    forceRADV = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to force applications to use RADV (Mesa's Implementation of Vulkan)";
    };
    # Support old cards for `radeon` driver
    iHaveRX500Series = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable support for RX500 series (OpenCL)";
    };
    iHaveRadeonHD7000Series = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable support for HD 7000 series";
    };
    iHaveRadeonHD8000Series = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable support for HD 8000 series";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      hardware.graphics = {
        enable = true;
      };
    })
    (lib.mkIf cfg.enable32Bit {
      hardware.graphics.enable32Bit = true;
    })
    (lib.mkIf cfg.enableHIP {
      systemd.tmpfiles.rules =
        let
          rocmEnv = pkgs.symlinkJoin {
            name = "rocm-combined";
            paths = with pkgs.rocmPackages; [
              rocblas
              hipblas
              clr
            ];
          };
        in
        [
          "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
        ];
    })
    (lib.mkIf cfg.enableOpenCL {
      hardware.graphics.extraPackages = with pkgs; [ rocmPackages.clr.icd ];
    })
    (lib.mkIf cfg.enableAMDVLK {
      hardware.graphics.extraPackages = with pkgs; [
        amdvlk
      ];
    })
    (lib.mkIf cfg.enableAMDVLK32Bit {
      hardware.graphics.extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    })
    (lib.mkIf cfg.forceRADV {
      environment.variables.AMD_VULKAN_ICD = "RADV";
    })
    (lib.mkIf cfg.iHaveRX500Series {
      environment.variables = {
        ROC_ENABLE_PRE_VEGA = "1";
      };
    })
    (lib.mkIf cfg.iHaveRadeonHD7000Series {
      boot.kernelParams = [
        "radeon.si_support=0"
        "amdgpu.si_support=1"
      ];
    })
    (lib.mkIf cfg.iHaveRadeonHD8000Series {
      boot.kernelParams = [
        "radeon.cik_support=0"
        "amdgpu.cik_support=1"
      ];
    })
  ];
}
