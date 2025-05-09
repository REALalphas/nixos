{
  config,
  lib,
  ...
}:

let
  cfg = config.system.git;
in
{
  options.system.git = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Whether to enable Git service (a version control system)";
  };

  config = lib.mkIf cfg {
    # Enable git program
    programs.git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "server";
        };
      };
    };
  };
}
