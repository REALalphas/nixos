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

    ## Gnome Extensions
  ]) ++ (with pkgs.gnomeExtensions; [
    # Tray icons
    appindicator
    # Shell blur
    blur-my-shell
    gsconnect

    # Shell blur
    # gnomeExtensions.blur-my-shell
    # FIXME: Geminiai
    # gnomeExtensions.gemini-ai
  ]);

}
