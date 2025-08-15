{
  ...
}:

{
  services.snipe-it = {
    enable = true;
    appKeyFile = ./snipe-it.secret;
    hostName = "snipe.nas-2xl.ru";
    database.createLocally = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
