{
  ...
}:

{
  services.snipe-it = {
    enable = true;
    appKeyFile = /home/alphas/snipe-it.secret;
    # hostName = "debugsnipeit.example.invalid";
    database.createLocally = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
