{
  config,
  lib,
  ...
}:

let
  cfg = config.system.boot;
in
{
  options.system.boot = {
    splash = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable plymouth splash screen";
    };
    silence = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to silence boot";
    };
    reduceTimeout = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Reduce bootloader timeout to 3 seconds";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.splash {
      boot.plymouth.enable = true;
    })
    (lib.mkIf cfg.silence {
      boot.consoleLogLevel = 3;
      boot.initrd.verbose = false;
      boot.kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "udev.log_priority=3"
        "rd.systemd.show_status=auto"
      ];
    })
    (lib.mkIf cfg.reduceTimeout {
      boot.loader.timeout = 3;
    })
  ];
}
