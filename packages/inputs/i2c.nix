{
  config,
  lib,
  ...
}:

let
  cfg = config.system.i2c;
in
{
  options.system.i2c = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable support of i2c devices";
  };

  config = lib.mkIf cfg {
    hardware.i2c.enable = true;
  };
}
