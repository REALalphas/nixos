{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.system.obs;
  idHIPEnabled = config.system.amdgpu.enableHIP;
  # TODO: Add support for graphics
  # isNvidia = config.system.nvidia.enable;
in
{
  options.system.obs = {
    description = "OBS Studio (Recording and Broadcasting software)";

    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable OBS Studio";
    };
    virtualCamera = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable in OBS Studio Virtual Camera Feature and add v4l2loopback to kernel";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.obs-studio = {
        enable = true;

        # optional Nvidia hardware acceleration
        # TODO: Nvidia Graphics
        # package = (
        #   pkgs.obs-studio.override {
        #     cudaSupport = true;
        #   }
        # );

        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-gstreamer
          obs-vkcapture
        ];
      };
    })
    (lib.mkIf cfg.virtualCamera {
      programs.obs-studio.enableVirtualCamera = true;
    })
    (lib.mkIf (cfg.enable && idHIPEnabled) {
      programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
        obs-vaapi # AMD GPU
      ];
    })
  ];
}
