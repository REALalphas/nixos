{
  lib,
  ...
}:

{
  networking.dhcpcd = {
    enable = true;
    wait = "background"; # Don't wait for DHCP response during boot
    extraConfig = ''
      noarp
      noipv4ll
      noipv6
    '';
  };
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp6s0.ipv4.addresses = [
  #   {
  #     address = "10.20.20.9";
  #     prefixLength = 24;
  #   }
  # ];
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;

  # networking.hostName = ""; #!!! Define your hostname in /config.nix

  # Pick only one of the below networking options.
  # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  # Not recommended for servers. Too much bloat. \/
  # networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes"; # "yes"
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;
}
