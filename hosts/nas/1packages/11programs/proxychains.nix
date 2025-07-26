{
  pkgs,
  ...
}:
{
  programs.proxychains.enable = true;
  programs.proxychains.package = pkgs.proxychains-ng;
  programs.proxychains.quietMode = true;
  programs.proxychains.proxies.happ_http = {
    enable = true;
    type = "http";
    host = "127.0.0.1";
    port = 10809;
  };
  programs.proxychains.proxies.happ_socks = {
    enable = true;
    type = "socks5";
    host = "127.0.0.1";
    port = 10808;
  };
}
