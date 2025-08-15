{
  ...
}:

{
  services.snipe-it = {
    enable = true;
    # hostName = "debugsnipeit.example.invalid";
    database.createLocally = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
