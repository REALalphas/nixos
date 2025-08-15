{
  ...
}:

{
  services.snipe-it = {
    enable = true;
    appKeyFile = /etc/nixos/hosts/movies/custom/snipe-it.secret;
    # hostName = "debugsnipeit.example.invalid";
    database.createLocally = true;
    tlsEnabled = false;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
