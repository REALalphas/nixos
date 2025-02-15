{
  config,
  pkgs,
  ...
}:
{
  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    # alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
    # wireplumber.enable = false;

    extraConfig = {
      pipewire."91-null-sinks" = {
        context.objects = [
          {
            factory = "adapter";
            args = {
              "factory.name" = "support.null-audio-sink";
              "node.name" = "MegaBassSystem";
              "node.description" = "MegaBassSystem";
              "media.class" = "Audio/Sink/Virtual";
              "audio.position" = "FL,FR";
            };
          }
        ];
      };
      pipewire."92-low-latency" = {
        context.properties = {
          default.clock.allowed-rates = [
            48000
            96000
          ];
          default.clock.rate = 96000;
          default.clock.quantum = 128;
          default.clock.min-quantum = 128;
          default.clock.max-quantum = 512;
        };
      };
      pipewire-pulse."92-low-latency" = {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.default.req = "128/96000";
              pulse.min.req = "128/96000";
              pulse.max.req = "128/96000";
              pulse.min.quantum = "128/96000";
              pulse.max.quantum = "128/96000";
            };
          }
        ];
        stream.properties = {
          node.latency = "128/96000";
          resample.quality = 1;
        };
      };
    };
  };

  # Rename Audio Devices and remove unneeded
  # environment.etc."wireplumber/main.lua.d/51-device-rename.lua".text = /* lua */ ''
  #   table.insert(alsa_monitor.rules, {
  #     matches = {
  #       {
  #         { "node.name", "equals", "alsa_output.usb-Audioengine_LLC_Audioengine_2__AE202010001A2002-00.analog-stereo" },
  #       },
  #     },
  #     apply_properties = {
  #       ["node.description"] = "Speakers",
  #       ["node.nick"] = "Speakers",
  #     },
  #   })
  #   table.insert(alsa_monitor.rules, {
  #     matches = {
  #       {
  #         { "node.name", "equals", "alsa_output.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-chat" },
  #       },
  #     },
  #     apply_properties = {
  #       ["node.description"] = "Headphones",
  #       ["node.nick"] = "Headphones",
  #     },
  #   })
  #   table.insert(alsa_monitor.rules, {
  #     matches = {
  #       {
  #         { "node.name", "equals", "alsa_input.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-chat" },
  #       },
  #     },
  #     apply_properties = {
  #       ["node.description"] = "Headphone Mic",
  #       ["node.nick"] = "Headphone Mic",
  #     },
  #   })
  #   table.insert(alsa_monitor.rules, {
  #     matches = {
  #       {{ "node.name", "equals", "alsa_output.usb-SteelSeries_SteelSeries_Arctis_5_00000000-00.analog-game" },},
  #     },
  #     apply_properties = {
  #       ["node.disabled"] = true,
  #     },
  #   })
  #   table.insert(alsa_monitor.rules, {
  #     matches = {
  #       {{ "node.name", "equals", "alsa_output.pci-0000_14_00.1.hdmi-stereo" },},
  #     },
  #     apply_properties = {
  #       ["node.disabled"] = true,
  #     },
  #   })
  #   table.insert(alsa_monitor.rules, {
  #     matches = {
  #       {{ "node.name", "equals", "alsa_input.usb-MACROSILICON_USB_Video-02.analog-stereo" },},
  #     },
  #     apply_properties = {
  #       ["node.disabled"] = true,
  #     },
  #   })
  # '';
}
