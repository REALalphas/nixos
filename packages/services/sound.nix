{
  config,
  lib,
  ...
}:

let
  cfg = config.system.sound;
in
{
  options.system.sound = {
    description = "Sound settings (Pipewire)";

    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable PipeWire framework";
    };
    enableRealtime = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable to enable rtkit";
    };
    airplay = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable RAOP (Apple AirPlay)";
      };
      increaceLatency = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to increace buffer latency to mitigate connection drops and audio glitches";
      };
    };
    config = {
      silenceBell = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to silence bell on X11 (Disable bell module)";
      };
      bluetooth = {
        enableAdvancedCodecs = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to enable SBC-XQ, mSBC, HSP, etc.";
        };
        disableCodecAutoSwitching = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Whether to disable mode switching to headset";
        };
      };
    };
    alsa = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable PipeWire's ALSA support";
      };
      enable32Bit = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable PipeWire's ALSA 32bit support";
      };
    };
    pulse = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable PipeWire's PulseAudio support";
      };
    };
    jack = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Whether to enable PipeWire's JACK Server support";
      };
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      services.pipewire.enable = true;
      services.pipewire.wireplumber.enable = true;
    })
    (lib.mkIf cfg.enableRealtime {
      security.rtkit.enable = true;
    })
    (lib.mkIf cfg.alsa.enable {
      services.pipewire.alsa.enable = true;
    })
    (lib.mkIf cfg.alsa.enable32Bit {
      services.pipewire.alsa.support32Bit = true;
    })
    (lib.mkIf cfg.pulse.enable {
      services.pipewire.pulse.enable = true;
    })
    (lib.mkIf cfg.jack.enable {
      services.pipewire.jack.enable = true;
    })
    # AirPlay
    (lib.mkIf cfg.airplay.enable {
      services.avahi.enable = true;
      # opens UDP ports 6001-6002
      services.pipewire.raopOpenFirewall = true;
      services.pipewire.extraConfig.pipewire."10-airplay"."context.modules" = [
        {
          name = "libpipewire-module-raop-discover";
        }
      ];
    })
    (lib.mkIf cfg.airplay.increaceLatency {
      services.extraConfig.pipewire."10-airplay"."context.modules" = [
        {
          name = "libpipewire-module-raop-discover";
          args = {
            "raop.latency.ms" = 500;
          };
        }
      ];
    })

    # Config
    (lib.mkIf cfg.config.silenceBell {
      services.pipewire.extraConfig.pipewire."99-silent-bell.conf" = {
        "context.properties" = {
          "module.x11.bell" = false;
        };
      };
    })
    (lib.mkIf cfg.config.bluetooth.enableAdvancedCodecs {
      services.pipewire.wireplumber.extraConfig."10-bluez" = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;
          "bluez5.roles" = [
            "hsp_hs"
            "hsp_ag"
            "hfp_hf"
            "hfp_ag"
          ];
        };
      };
    })
    (lib.mkIf cfg.config.bluetooth.disableCodecAutoSwitching {
      services.pipewire.wireplumber.extraConfig."11-bluetooth-policy" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
      };
    })
  ];
}
