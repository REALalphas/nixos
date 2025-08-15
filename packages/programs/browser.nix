{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.system.browser;
in
{
  options.system.browser = {
    description = "Web Browser";

    provider = lib.mkOption {
      type = lib.types.enum [
        "none"
        "firefox"
        "firefox-beta"
        "firefox-esr"
        "firefox-dev"
        "librewolf"
      ];
      default = "none"; # Changed default to a valid provider
      description = "Select your preferred browser option";
    };

    useBin = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to use pre-compiled binary or not";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf
      (lib.elem cfg.provider [
        "firefox"
        "firefox-beta"
        "firefox-esr"
        "firefox-dev"
        "librewolf"
      ])
      {
        programs.firefox = {
          enable = true;
          package =
            let
              binaryPkgs = {
                "firefox" = pkgs.firefox-bin;
                "firefox-beta" = pkgs.firefox-beta;
                "firefox-esr" = pkgs.firefox-esr;
                "firefox-dev" = pkgs.firefox-devedition;
                "librewolf" = pkgs.librewolf-bin;
              };

              sourcePkgs = {
                "firefox" = pkgs.firefox;
                "firefox-beta" = pkgs.firefox-beta;
                "firefox-esr" = pkgs.firefox-esr;
                "firefox-dev" = pkgs.firefox-devedition;
                "librewolf" = pkgs.librewolf;
              };

              selectedPkgs = if cfg.useBin then binaryPkgs else sourcePkgs;

            in
            selectedPkgs.${cfg.provider};
        };
      }
    )
    (lib.mkIf (cfg.provider == "chrome") {
      # TODO: Add chrome
      # TODO: Add KDE Check
    })
  ];
}
