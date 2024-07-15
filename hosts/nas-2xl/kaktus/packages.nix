# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # Vivaldi
    unstable.vivaldi
    unstable.vivaldi-ffmpeg-codecs

    # Discord + Vencord and OpenASAR
    (discord.override {
      # withOpenASAR = true;
      withVencord = true;
    })

    # OBS Studio and plugins
    unstable.obs-studio
    obs-studio-plugins.obs-vaapi

    # Blender
    blender-hip

    # Pipewire stuff
    unstable.easyeffects
    helvum
  ];
}
