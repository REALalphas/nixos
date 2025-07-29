{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.system.lact;
  isAMD = config.system.amdgpu.enable;
in
{
  options.system.lact = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Whether to enable Linux AMDGPU Controller";
  };

  config = lib.mkIf (cfg && isAMD) {
    environment.systemPackages = with pkgs; [ lact ];
    systemd.packages = with pkgs; [ lact ];
    systemd.services.lactd.wantedBy = [ "multi-user.target" ];
    systemd.services.lactd.description = "Linux AMDGPU Controller Daemon";
  };
}
