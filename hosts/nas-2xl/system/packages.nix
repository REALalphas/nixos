# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, ... }:

{
  # Enable nix-ld to run unpatched dynamic binaries
  programs.nix-ld.enable = true;

  # Steam
  programs.steam.enable = true;

  # DistroBox (BoxBuddy) and Podman
  virtualisation.podman.enable = true;

  # ArchiSteamFarm
  services.archisteamfarm = {
    enable = true;
    web-ui.enable = true;
  };

  # Virt-Manager and LibVirt Daemon
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
    };
  };
  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';

  # OpenTabletDriver
  hardware.opentabletdriver.enable = true;

  # Open LLMs engine
  services.ollama = {
    # package = pkgs.ollama;
    enable = true;
    acceleration = "rocm";
    listenAddress = "0.0.0.0:11434";
  };

  # GStreamer libs
  environment.sessionVariables.GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
    gst-plugins-good
    gst-plugins-bad
    gst-plugins-ugly
    gst-libav
  ]);

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
    gnome.gnome-sound-recorder
    networkmanagerapplet

    spotify
    noto-fonts
    fira-code
    nano
    wget
    nfs-utils
    pkgs.protonvpn-gui

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

    # ffmpeg
    # unstable.ffmpeg_7-full
    jellyfin-ffmpeg


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

    # File size tree
    ncdu

    # Game streaming
    sunshine

    # AMD AMF headers
    unstable.amf-headers

    # VirtIO File System Directory
    virtiofsd

    libva
    libva-utils

    python3
    # pythonPackages.tkinter
    # pythonPackages.pyautogui
    # pythonPackages.pydevtool
    # pythonPackages.pip
    scrot

    amberol
    gamescope
    unstable.warp-terminal
    nixpkgs2311.yuzu-mainline

    moonlight-qt
  ];
}
