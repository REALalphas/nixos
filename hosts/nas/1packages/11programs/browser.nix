
{ config, pkgs, ... }:
{
  # Firefox
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox-devedition;
  };
}