# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ lib, pkgs, ... }:

{
  # Enable nix-ld to run unpatched dynamic binaries
  programs.nix-ld.enable = true;

  # Steam
  programs.steam.enable = true;
  programs.steam.extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];

  # DistroBox (BoxBuddy) and Podman
  # virtualisation.podman.enable = true;

  # ArchiSteamFarm
  services.archisteamfarm = {
    enable = true;
    web-ui.enable = true;
  };

  # Gamemode
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        renice = 10;
      };

      # WARN: GPU optimisations have the potential to damage hardware
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        amd_performance_level = "high";
      };

      custom = {
        start = "${pkgs.libnotify}/bin/notify-send 'Gamemode enabled'";
        end = "${pkgs.libnotify}/bin/notify-send 'Gamemode disabled'";
      };
    };
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

  # Mozilla VPN
  services.mozillavpn.enable = true;

  # Open LLMs engine
  # services.ollama = {
  #   package = pkgs.unstable.ollama-rocm;
  #   enable = true;
  #   acceleration = "rocm";
  #   host = "0.0.0.0";
  #   port = 11434;
  # };

  # Open source AI Assistant for coding
  services.tabby = {
    enable = true;
    acceleration = "cpu";
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
    # unstable.distrobox
    # unstable.boxbuddy

    # Fast json...
    jq

    # .nix formatter
    nixpkgs-fmt

    icu
    # OnlyOffice Desktop
    onlyoffice-bin

    # Just gnome twerks
    gnome.gnome-tweaks
    gnome.gnome-sound-recorder
    # Gnome Extensions
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.gemini-ai

    networkmanagerapplet

    spotify
    noto-fonts
    fira-code
    nano
    wget
    nfs-utils

    gptfdisk
    dmg2img

    # Signal Desktop
    unstable.signal-desktop

    # Bottles (games launcher)
    (bottles.override { extraLibraries = pkgs: [ libunwind ]; })
    (lutris.override { extraLibraries = pkgs: [ libunwind ]; })
    # Heroic
    (heroic.override { extraLibraries = pkgs: [ stdenv.cc.cc.lib ]; })
    # Cartridges
    cartridges

    # ffmpeg
    # unstable.ffmpeg_7-full
    # jellyfin-ffmpeg


    # SMPlayer (mpv and mplayer)
    unstable.smplayer
    mpv-unwrapped
    mplayer

    gnome.dconf-editor
    audacity

    neofetch

    # File size tree
    ncdu

    # Game streaming
    # sunshine

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

    # Port Audio API for pituhon
    alsa-lib
    portaudio
  ];
}
