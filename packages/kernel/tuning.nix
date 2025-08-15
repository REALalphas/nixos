{
  config,
  lib,
  ...
}:

let
  cfg = config.system.tuning;
in
{
  options.system.tuning = {
    performance = {
      description = "Settings to improve system speed and responsiveness";

      filesystemCacheBehavior = lib.mkOption {
        type = lib.types.enum [
          "none"
          "balanced"
          "responsive"
          "aggressive-caching"
          "large-files"
        ];
        default = "none";
        description = ''
          Controls how the kernel caches filesystem information.

          - "balanced": A good middle-ground for all workloads. The standard Linux default.
          - "responsive": Optimizes for faster application startup and directory browsing. Ideal for most desktops and laptops.
          - "aggressive-caching": Strongly prefers keeping filesystem data in RAM for maximum responsiveness.
          - "large-files": Optimizes for workloads that repeatedly read large files (e.g., video editing, database servers).
        '';
      };

      reduceDiskIOStutter = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Tunes disk I/O to prioritize system responsiveness, reducing micro-stutters during heavy disk activity.";
      };

      increaseFileWatchLimits = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Prevents errors in development tools and file-syncing apps when they monitor a large number of files.";
      };
    };

    security = {
      description = "Settings to harden the kernel and reduce attack surfaces";
      disableUnprivilegedBPF = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Restricts a powerful kernel feature (eBPF) from normal users. May break some niche applications.";
      };
      hardenProcessInspection = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Helps prevent malicious applications from injecting code into or spying on other running programs.";
      };
      protectAgainstLinkAttacks = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enables kernel protections against a class of attacks involving symbolic and hard links, which are often used in temporary directories.";
      };
    };

    reliability = {
      description = "Settings to improve system stability and prevent lock-ups";

      prioritizeRAMOverSwap = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Tells the kernel to strongly prefer using RAM instead of the swap file on your disk. Improves performance on modern systems with 8GB+ RAM";
      };
      preventSystemLockupsOnLowMemory = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Prevents the entire system from freezing when it runs out of memory. Kernel will terminate the single application that caused the problem";
      };
      allowAppsToUseMoreMemoryMappings = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Allows applications to request more memory regions from the kernel. This is REQUIRED by many modern games and some development tools to avoid crashes.";
      };
    };
  };

  config = {
    boot.kernel.sysctl = lib.mkMerge [
      (lib.mkIf (cfg.performance.filesystemCacheBehavior == "balanced") {
        "vm.vfs_cache_pressure" = 100;
      })
      (lib.mkIf (cfg.performance.filesystemCacheBehavior == "responsive") {
        "vm.vfs_cache_pressure" = 80;
      })
      (lib.mkIf (cfg.performance.filesystemCacheBehavior == "aggressive-caching") {
        "vm.vfs_cache_pressure" = 50;
      })
      (lib.mkIf (cfg.performance.filesystemCacheBehavior == "large-files") {
        "vm.vfs_cache_pressure" = 150;
      })

      (lib.mkIf cfg.performance.reduceDiskIOStutter {
        "vm.dirty_background_ratio" = 5;
        "vm.dirty_ratio" = 15;
      })
      (lib.mkIf cfg.performance.increaseFileWatchLimits {
        "fs.inotify.max_user_watches" = 524288;
      })

      (lib.mkIf cfg.security.disableUnprivilegedBPF { "kernel.unprivileged_bpf_disabled" = 2; })
      (lib.mkIf cfg.security.hardenProcessInspection { "kernel.yama.ptrace_scope" = 1; })
      (lib.mkIf cfg.security.protectAgainstLinkAttacks {
        "fs.protected_hardlinks" = 1;
        "fs.protected_symlinks" = 1;
      })

      (lib.mkIf cfg.reliability.prioritizeRAMOverSwap {
        "vm.swappiness" = 10;
      })
      (lib.mkIf cfg.reliability.preventSystemLockupsOnLowMemory {
        "vm.overcommit_memory" = 2;
      })
      (lib.mkIf cfg.reliability.allowAppsToUseMoreMemoryMappings {
        "vm.max_map_count" = 16777216;
      })
    ];
  };
}
