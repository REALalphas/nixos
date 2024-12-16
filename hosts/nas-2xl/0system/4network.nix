{ config
, lib
, pkgs
, modulesPath
, ...
}:
{
  # !!! See /flake.nix
  # networking.hostName = "nas-2xl";

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable wireless support via wpa_supplicant. (Optional when using networkmanager)
  # networking.wireless.enable = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  ## Firewall
  # Firewall is turned on by default, so this line is not necessary
  networking.firewall.enable = false;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  ## DHCP Interfaces
  # By default all interfaces (wireless also) use dhcp
  # You can set manually with explicit per-interface declarations with
  # `networking.interfaces.<interface>.useDHCP`
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

}
