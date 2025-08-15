{
  ...
}:

let
  host = "snipe.nas-2xl.ru";
in
{
  services.snipe-it = {
    enable = true;
    hostName = host;
    appURL = "https://${host}";
    appKeyFile = ./snipe-it.secret;

    database.createLocally = true;
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
