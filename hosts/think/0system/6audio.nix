{ config
, pkgs
, ...
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
      pipewire."92-low-latency" = {
        context.properties = {
          default.clock.allowed-rates = [ 48000 96000 ];
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

}
