{ inputs, pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      ### Web Browsers
      # Vivaldi web browser
      # unstable.vivaldi
      # unstable.vivaldi-ffmpeg-codecs

      # Tor Browser - Privacy-focused browser
      # unstable.tor-browser

      # Floorp web browser
      # unstable.floorp
      # vdhcoapp

      # Firefox Developer Edition
      # firefox-devedition

      ### Security & Privacy
      # Password manager
      keepassxc

      ### Media & Entertainment
      # osu!lazer - Rhythm game
      # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
      # unstable.osu-lazer-bin

      # Image/video version comparison tool
      # unstable.identity

      # Music streaming client
      unstable.spotify

      ### Communication
      # Discord Web client with Wayland support
      vesktop

      # Matrix chat client
      # element-desktop

      ### Development
      # GTK4 Ollama client # See 10services.nix
      # unstable.alpaca

      # Lua development
      # lua
      # luajitPackages.luarocks

      # Modern SQL client
      # unstable.beekeeper-studio

      ### Gaming & Emulation
      # PS3 emulator/debugger
      # rpcs3

      # Nintendo Switch Emulator
      # nix23-11.yuzu-mainline

      # Minecraft launcher
      prismlauncher

      # Game streaming client
      # moonlight-qt

      ### System Utilities
      # TCP Traffic Shaker
      # unstable.spoofdpi

      # Monitor control utility
      # ddcutil

      ### Creative Tools
      # Image editor similar to Paint.NET
      # pinta

      # Note taking application
      # obsidian

      ### Finance
      # Cryptocurrency wallet
      # exodus

    ])
    ### GNOME Extensions
    ++ (with pkgs.gnomeExtensions; [
      # Tray icons
      appindicator
      # Shell blur
      blur-my-shell
      # Connector for phone
      gsconnect
      # Hides bar to allow waydroid full screen
      hide-top-bar
      # Don't show overview on start
      no-overview

    ]);
  # Enabled extensions
  dconf.settings."org/gnome/shell" = {
    disable-user-extensions = false;
    enabled-extensions = with pkgs.gnomeExtensions; [
      blur-my-shell.extensionUuid
      gsconnect.extensionUuid
      appindicator.extensionUuid
      hide-top-bar.extensionUuid
      no-overview.extensionUuid
    ];
  };
}
