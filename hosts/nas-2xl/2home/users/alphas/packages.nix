{ inputs
, pkgs
, ...
}:
{
  home.packages = (with pkgs; [
    # osu!lazer
    # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    unstable.osu-lazer-bin

    gnome-frog

    # Vivaldi
    # unstable.vivaldi
    # unstable.vivaldi-ffmpeg-codecs

    # Tor Browser
    # unstable.tor-browser

    # Floorp
    # unstable.floorp
    # vdhcoapp

    # Firefox
    # firefox-devedition

    # qBittorrent
    # qbittorrent

    # Moonlight (client for straming)
    # moonlight-qt

    # Wine
    # wine64
    # winetricks

    # Node.js for development
    # nodejs
    # Bun
    # bun

    # Discord + Vencord and OpenASAR
    # (discord.override {
    #   # withOpenASAR = true;
    #   # withVencord = true;
    # })

    # Obsidian
    # obsidian

    # unstable.prismlauncher

    # Editor
    # unstable.zed-editor

    # Util for monitoring usage of amdgpu
    # amdgpu_top

    # blender-hip

    # OBS Studio and plugins
    # unstable.obs-studio
    # obs-studio-plugins.obs-vaapi

    # KeePassXC (Password manager)
    keepassxc
    # Reminna (SSH + RD Client)
    # remmina
    # JSTest (Gamepad and 'xinput' tester)
    # jstest-gtk
    # Ventoy cli installer
    # ventoy-full
    # Piper (Mouse settings editor)
    # piper

    # pitivi

    # unstable.gnome-builder
    # unstable.flatpak-builder

    # Warp Terminal
    # unstable.warp-terminal

    # Yuzu Nintendo Switch Emulator
    # nixpkgs2311.yuzu-mainline

    # ALVR
    # unstable.alvr

    # Android Tools and Scrcpy
    # android-tools
    # scrcpy

    # moonlight-qt

    # Pipewire stuff
    # unstable.easyeffects
    # helvum

    # Spotify
    # spotify

    # A program for comparing multiple versions of an image or video
    unstable.identity

    # Discord Web client with Wayland support and preinstalled Vencord
    vesktop

    # Formatter # See programs.nix
    nixpkgs-fmt

    # Ollama client made with GTK4 and Adwaita # See 10services.nix
    unstable.alpaca

    # PS3 emulator/debugger
    rpcs3

    # Nintendo Switch Emulator
    nix23-11.yuzu-mainline

    # TCP Traffic Shaker
    unstable.spoofdpi

    # DDC util (Control monitor)
    ddcutil

    # A feature-rich client for Matrix.org
    element-desktop

    # Drawing/editing program modeled after Paint.NET
    pinta

    prismlauncher

    moonlight-qt

    # Crypto Wallet
    exodus

    # Spotify Music Client
    spotify
  ]);
}
