{
  pkgs,
  ...
}:
{
  # !!! List packages installed in SYSTEM
  # To search run: `$ nix search wget`
  environment.systemPackages = (
    with pkgs;
    [
      ### System Utilities
      # Text editor (cli)
      nano

      # Nix formatter # See programs.nix
      nixfmt-rfc-style

      # Rustdesk
      rustdesk-flutter

      # Gnome Tweaks for autostart settings
      gnome-tweaks

      # Change GNOME desktop entries
      alacarte

      # NFS Support # See 5systemd.nix # See 10services.nix
      # nfs-utils

      # Linux AMDGPU Controller (LACT) # See 10services.nix
      # lact

      # MangoHud (Gaming overlay)
      # mangohud

      # Backup utility
      # pika-backup

      # Fuzzy find
      fzf

      # Distrobox
      # distrobox

      # Universal proxy platform
      # sing-box

      # Duplicate file finder
      # czkawka

      ### Media & Entertainment
      # Sound recorder
      # gnome-sound-recorder

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
      # obs-studio

      # Davinci Resolve (Video Editor)
      # davinci-resolve

      # Professional video editor
      # kdePackages.kdenlive

      # 3D Creation/Animation/Publishing System
      # blender-hip

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
      # OnlyOffice Editors
      # onlyoffice-bin_latest

      # Web browser
      # chromium

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
      # nodejs_22

      # NodeJS gyp
      # gobject-introspection
      # cairo
      # pkg-config

      ### Communication
      # Secure messaging application
      signal-desktop

      # Cross-platform universal messaging app
      # beeper

      ### Remote Access
      # Remote desktop client supporting multiple protocols
      # remmina

      # Remote Control an Android device
      scrcpy

      ### Media Server
      # Jellyfin (Home Media Server) # See 10services.nix
      # jellyfin
      # jellyfin-web
      # jellyfin-ffmpeg

      ### File Sharing
      # BitTorrent Client
      qbittorrent

      ### Image Processing
      # Simple & useful image compressor
      # unstable.curtail

      # Image manipulation tools
      # imagemagick

      ### Gaming
      # Bottles (games launcher)
      # (bottles.override { extraLibraries = pkgs: [ libunwind ]; })
      # Cartridges
      # cartridges

      ### Theming
      # QT Adwaita theme # See configuration.nix
      # adwaita-qt
      # adwaita-qt6
      # qadwaitadecorations-qt6
      # QT Gnome platform
      # qgnomeplatform
      # qgnomeplatform-qt6

      # Ladybird Browser (Fork from SerenityOS)
      # unstable.ladybird

      # Epiphany Browser (WebKit Browser from Gnome)
      epiphany
    ]
  );
}
