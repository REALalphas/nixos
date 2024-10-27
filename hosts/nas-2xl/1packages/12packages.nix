{ config
, pkgs
, ...
}:
{
  # !!! List packages installed in SYSTEM
  # To search run: `$ nix search wget`
  environment.systemPackages = (with pkgs; [

    # Text editor (cli)
    nano

    # NFS Support # See 5systemd.nix # See 10services.nix
    nfs-utils

    # Sound recorder
    gnome.gnome-sound-recorder

    # Audio player
    # amberol (depr)
    unstable.decibels

    # FIXME: Video player
    mpv
    mplayer
    smplayer

    # Simple image viewer application written with GTK4 and Rust
    unstable.loupe

    # OnlyOffice Editors
    onlyoffice-bin_latest

    # Audio effects for PipeWire applications
    easyeffects
    # GTK patchbay for PipeWire
    helvum

    # Backup utility
    pika-backup

    # Free and open source software for video recording and live streaming
    obs-studio

    # Davinci Resolve (Video Editor)
    davinci-resolve

    # 3D Creation/Animation/Publishing System
    blender-hip

    # IDE for Android
    androidStudioPackages.dev
    # Android SDK platform tools
    android-tools
    # Android Studio CLI Tools
    android-studio-tools
    # Flutter is Google's SDK for building mobile, web and desktop with Dart
    flutter

    # Sigma messanger
    signal-desktop

    # RDP, VNC, SSH... Client
    remmina

    # Remote Controll an Android device
    scrcpy

    # BitTorrent Client
    qbittorrent

    # Simple & useful image compressor
    unstable.curtail

    # Bottles (games launcher)
    (bottles.override { extraLibraries = pkgs: [ libunwind ]; })
    # Cartridges
    cartridges

    ## Rasberry Pi Pico Development
    gcc
    go
    elixir
    libclang
    python3
    libusb1
    # openocd
    openocd-rp2040
    pico-sdk
    picotool
    ninja

    # Jellyfin (Home Media Server) # See 10services.nix
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg

    # Cisco Packet Tracer
    ciscoPacketTracer8

    # QT Adwaita theme # See configuration.nix
    adwaita-qt
    adwaita-qt6
    qadwaitadecorations-qt6
    # QT Gnome platform
    qgnomeplatform
    qgnomeplatform-qt6

    ## Gnome Extensions
  ]) ++ (with pkgs.gnomeExtensions; [
    # Tray icons
    appindicator
    # Shell blur
    blur-my-shell
    gsconnect
    # DDC controll
    control-monitor-brightness-and-volume-with-ddcutil

    # Shell blur
    # gnomeExtensions.blur-my-shell
    # FIXME: Geminiai
    # gnomeExtensions.gemini-ai
  ]);

}
