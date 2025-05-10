{
  config,
  lib,
  ...
}:

let
  cfg = config.system.htop;
in
{
  options.system.htop = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether to enable htop process monitor";
  };

  config = lib.mkIf cfg {
    programs.htop.enable = true;
  };
}
