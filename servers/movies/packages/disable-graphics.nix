{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.system.headless;
in
{
  options.system.headless = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether to disable all graphical/X11 related services and features";
  };

  config = lib.mkIf cfg {
    # Disable all graphical/X11 related services
    services.xserver.enable = false;
    services.xserver.excludePackages = with pkgs; [
      xterm
      xorg.xorgserver
      xorg.xinit
    ];

    # Explicitly disable any graphics-related features
    environment.noXlibs = true;
    hardware.opengl.enable = false;
  };
}
