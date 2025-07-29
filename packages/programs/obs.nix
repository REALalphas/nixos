{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.system.obs;
  # TODO: Add support for graphics
  # isAMD = config.system.amdgpu.enable;
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
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      programs.obs-studio = {
        enable = true;

        # It will add v4loopback to kernel
        enableVirtualCamera = true;

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
          # TODO: AMD Graphics
          # obs-vaapi # optional AMD hardware acceleration
          obs-gstreamer
          obs-vkcapture
        ];
      };
    })
  ];
}
