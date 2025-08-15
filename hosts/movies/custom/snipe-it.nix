{
  ...
}:

{
  services.snipe-it = {
    enable = true;
    appKeyFile = ./snipe-it.secret;
    # hostName = "movies.xl";
    database.createLocally = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
