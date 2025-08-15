{
  ...
}:

{
  services.snipe-it = {
    enable = true;
    appKeyFile = ./snipe-it.secret;
    # hostName = "debugsnipeit.example.invalid";
    database.createLocally = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
