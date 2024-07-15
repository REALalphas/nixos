# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  # Exclude Default
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome.gnome-maps
    gnome.yelp
  ];


  # environment.systemPackages = [
  #   pkgs.gnomeExtensions.appindicator
  #   pkgs.gnomeExtensions.blur-my-shell
  # ];
}
