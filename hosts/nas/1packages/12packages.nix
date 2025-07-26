{
  pkgs,
  ...
}:
{
  # !!! List packages installed in SYSTEM
  # To search run: `$ nix search wget`
  environment.systemPackages =
    (with pkgs; [
      ### System Utilities
      # Text editor (cli)
      nano

      # # NTFS-3G (NTFS filesystem driver)
      # ntfs3g

      # Nix formatter # See programs.nix
      unstable.nixfmt-rfc-style
      # Language Server for Python (Zed)
      python313Packages.python-lsp-server
      python313Packages.plyvel

      # Python
      python313Full
      python313Packages.requests

      # NFS Support # See 5systemd.nix # See 10services.nix
      nfs-utils

      # Linux AMDGPU Controller (LACT) # See 10services.nix
      lact

      # MangoHud (Gaming overlay)
      mangohud

      # Backup utility
      pika-backup

      # Fuzzy find
      fzf

      # Distrobox
      distrobox

      # Proxy Tunneling Utility
      tun2proxy

      # System information
      unstable.hardinfo2

      # Universal proxy platform
      # sing-box

      # Duplicate file finder
      # czkawka

      ### Media & Entertainment
      # Sound recorder
      gnome-sound-recorder

      # Modern GTK4 audio player
      # amberol # (depr)
      unstable.decibels

      # Video players
      mpv
      mplayer
      smplayer

      # Simple image viewer application written with GTK4 and Rust
      unstable.loupe

      ### Media Creation
      # Free and open source software for video recording and live streaming
      obs-studio

      # Davinci Resolve (Video Editor)
      # davinci-resolve

      # Professional video editor
      # kdePackages.kdenlive

      # 3D Creation/Animation/Publishing System
      blender-hip

      ### Audio Tools
      # Audio effects for PipeWire applications
      easyeffects
      # GTK patchbay for PipeWire
      # helvum

      # Audio plugin host and patchbay
      carla

      # Room Eq Wizard
      # roomeqwizard

      ### Office & Productivity
      # OnlyOffice Editors (Office suite)
      onlyoffice-bin_latest

      # Web browser
      # Open source web browser from Google
      chromium
      # Fork of Firefox, focused on privacy, security and freedom
      librewolf

      ### Development
      ## Mobile Development
      # IDE for Android
      # androidStudioPackages.dev

      # Android SDK platform tools
      # android-tools

      # Android Studio CLI Tools
      # android-studio-tools

      # Flutter is Google's SDK for building mobile, web and desktop with Dart
      # flutter

      ## Raspberry Pi Pico Development
      # gcc               # C/C++ compiler
      # go                # Go programming language
      # elixir            # Elixir programming language
      # libclang          # LLVM C language frontend
      # python3           # Python programming language
      # libusb1           # USB device access library
      # openocd           # Original OpenOCD
      # openocd-rp2040    # Debug adapter for RP2040
      # pico-sdk          # Raspberry Pi Pico SDK
      # picotool          # Raspberry Pi Pico utility
      # ninja             # Build system

      ## Web Development
      # NodeJS Runtime
      nodejs_24

      # NodeJS gyp
      # gobject-introspection
      # cairo
      # pkg-config

      ### Communication
      # Secure messaging application
      signal-desktop
      unstable.beeper

      # Cross-platform universal messaging app
      # beeper

      ### Remote Access
      # Remote desktop client supporting multiple protocols
      remmina

      # Remote Control an Android device
      # scrcpy

      ### Media Server
      # Jellyfin (Home Media Server) # See 10services.nix
      # jellyfin
      # jellyfin-web
      # jellyfin-ffmpeg

      ### File Sharing
      # BitTorrent Client
      unstable.qbittorrent

      ### Image Processing
      # Simple & useful image compressor
      unstable.curtail

      # Image manipulation tools
      imagemagick

      ### Gaming
      # Bottles (games launcher)
      (bottles.override { extraLibraries = pkgs: [ libunwind ]; })
      # Cartridges
      cartridges

      ### Theming
      # QT Adwaita theme # See configuration.nix
      adwaita-qt
      adwaita-qt6
      qadwaitadecorations-qt6
      # QT Gnome platform
      qgnomeplatform
      qgnomeplatform-qt6

      # Ladybird Browser (Fork from SerenityOS)
      # unstable.ladybird

      # Go lang
      go

      # ROCm Tools
      rocmPackages.rocm-smi
      rocmPackages.rocminfo

      # LM-Studio
      lmstudio

      # Qt
      unstable.libsForQt5.qt5.qtwayland
      kdePackages.qtwayland

      ### GNOME Extensions
    ])
    ++ (with pkgs.gnomeExtensions; [
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
