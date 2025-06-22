{
  pkgs,
  ...
}:
{
  home.packages = (
    with pkgs;
    [
      #######################
      # Development Tools
      #######################

      # Editors and LSP
      unstable.zed-editor # Modern code editor
      nixd # Nix Language Server
      nil # Alternative Nix Language Server

      # Version Control
      # gh # GitHub CLI

      # Development Tools
      # unstable.alpaca       # GTK4 Ollama client
      unstable.nixfmt-rfc-style # Nix formatter
      insomnia # API Testing platform

      # Programming Languages
      luajit # Lua interpreter
      luajitPackages.luarocks # Lua package manager
      luajitPackages.http
      luajitPackages.luasocket

      #######################
      # System & Utilities
      #######################

      # Package Management
      unstable.flatpak
      unstable.gnome-software

      # System Tools
      unstable.spoofdpi # TCP Traffic Shaker
      ddcutil # Monitor control utility

      #######################
      # Security & Privacy
      #######################

      keepassxc # Password manager

      #######################
      # Communication
      #######################

      (discord.override {
        withVencord = true;
      }) # Official Discord client with Vencord
      # discord # Official Discord client
      vesktop # Discord Web client with Wayland support
      # element-desktop # Matrix chat client

      #######################
      # Media & Entertainment
      #######################

      # Media Applications
      # unstable.identity # Image/video comparison tool
      unstable.spotify # Music streaming client
      pinta # Image editor (Paint.NET alternative)
      # yt-dlp # YouTube downloader

      # Gaming
      unstable.osu-lazer-bin # Rhythm game
      # rpcs3 # PS3 emulator
      # nix23-11.yuzu-mainline # Nintendo Switch Emulator
      nix24-11.torzu
      prismlauncher # Minecraft launcher

      # Dev builder and env for browser
      nix24-11.nodePackages.parcel

      #######################
      # Productivity
      #######################

      obsidian # Note taking application
      newsflash # News rss reader

      ################################
      # Currently Disabled Packages
      ################################

      # Web Browsers
      # unstable.vivaldi
      # unstable.vivaldi-ffmpeg-codecs
      # unstable.tor-browser
      # unstable.floorp
      # vdhcoapp
      # firefox-devedition

      # Development
      # unstable.beekeeper-studio    # SQL client

      # Gaming & Streaming
      # moonlight-qt               # Game streaming client
      # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin

      # Utilities & Other
      # unstable.rustdesk-flutter  # Remote desktop
      # exodus                     # Cryptocurrency wallet
    ]
  );
}
