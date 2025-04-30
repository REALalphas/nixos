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
    default = false;
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

    # Prevent automatic enabling of graphical features
    nixpkgs.config.packageOverrides = pkgs: {
      mesa = null;
      xorg = null;
    };

    # Explicitly disable any graphics-related features
    environment.noXlibs = true;
    hardware.opengl.enable = false;

    # Disable GUI components of nix-index-database
    programs.command-not-found.enable = false;
    environment.variables = {
      WEBKIT_DISABLE_COMPOSITING_MODE = "1";
      NIXINDEX_NO_GUI = "1";
    };
  };
}
