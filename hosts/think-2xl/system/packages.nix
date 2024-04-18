# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  # Enable nix-ld to run unpatched dynamic binaries
  programs.nix-ld.enable = true;

  # Steam
  programs.steam.enable = true;

  # DistroBox (BoxBuddy) and Podman
  virtualisation.podman.enable = true;

  # Virt-Manager and LibVirt Daemon
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';

  # OpenTabletDriver
  hardware.opentabletdriver.enable = true;

  # Open LLMs engine
  services.ollama = {
    package = pkgs.unstable.ollama;
    enable = true;
    # acceleration = "rocm";
    listenAddress = "0.0.0.0:11434";
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

    # DistroBox (BoxBuddy) and Podman
    unstable.distrobox
    unstable.boxbuddy

    # Fast json...
    jq

    # .nix formatter
    nixpkgs-fmt

    icu
    # OnlyOffice Desktop
    pkgs.onlyoffice-bin

    # Just gnome twerks
    pkgs.gnome.gnome-tweaks
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.blur-my-shell
    networkmanagerapplet

    spotify
    noto-fonts
    fira-code
    nano
    wget
    nfs-utils
    pkgs.protonvpn-gui
    keepassxc

    gptfdisk
    dmg2img

    # Signal Desktop
    unstable.signal-desktop



    # Bottles (games launcher)
    # bottles-unwrapped
    (bottles.override { extraLibraries = pkgs: [ pkgs.libunwind ]; })
    (lutris.override { extraLibraries = pkgs: [ pkgs.libunwind ]; })
    # Heroic
    # heroic
    (heroic.override { extraLibraries = pkgs: [ pkgs.stdenv.cc.cc.lib ]; })
    # Cartridges
    cartridges

    nvtop-amd
    # GStreamer and ffmpeg
    ffmpeg
    gst_all_1.gstreamer
    gst_all_1.gst-vaapi

    # Kdenlive (Video Editor)
    unstable.kdePackages.kdenlive
    # SMPlayer (mpv and mplayer)
    unstable.smplayer
    mpv-unwrapped
    mplayer

    gnome.dconf-editor
    audacity

    unstable.alvr

    neofetch

    android-tools
    scrcpy
  ];
}
