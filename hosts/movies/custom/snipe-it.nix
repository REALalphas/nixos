{
  ...
}:

{
  services.snipe-it = {
    enable = true;
    appKeyFile = /run/keys/snipe-it/appkey;
    # hostName = "debugsnipeit.example.invalid";
    database.createLocally = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
