{
  config,
  lib,
  ...
}:

let
  cfg = config.system.networkmanager;
in
{
  options.system.networkmanager = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable NetworkManager";
    };
    singlePointCustomDNSManagement = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to disable NetworkManager's DNS Management";
    };
    powerSave = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether to enable power saving options";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      networking.networkmanager.enable = true;
    })
    (lib.mkIf cfg.singlePointCustomDNSManagement {
      # Disable nm dns
      networking.networkmanager.dns = "none";
      # Allow nm to use DHCP instead of dhcpcd
      networking.useDHCP = false;
      networking.dhcpcd.enable = false;
      # Set DNS if user aren't
      networking.nameservers = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.8.4.4"
      ];
    })
    (lib.mkIf cfg.powerSave {
      networking.networkmanager.wifi.powersave = true;
    })
  ];
}
