{
  config,
  lib,
  ...
}:

let
  cfg = config.system.git;
in
{
  options.system.git = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable Git service (a version control system)";
    };
    branch = lib.mkOption {
      type = lib.types.string;
      default = "master";
      description = "Set default branch";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      config = {
        init = {
          defaultBranch = cfg.branch;
        };
      };
    };
  };
}
