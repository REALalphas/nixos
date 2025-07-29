{
  config,
  lib,
  ...
}:

let
  cfg = config.system.opentabletdriver;
in
{
  options.system.opentabletdriver = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable OpenTabletDriver";
  };

  config = lib.mkIf cfg {
    hardware.opentabletdriver.enable = true;
  };
}
