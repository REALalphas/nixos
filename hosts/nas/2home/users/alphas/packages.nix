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
      gh # GitHub CLI

      # Development Tools
      # unstable.alpaca       # GTK4 Ollama client
      unstable.nixfmt-rfc-style # Nix formatter
      insomnia # API Testing platform

      # Programming Languages
      lua # Lua interpreter
      luajitPackages.luarocks # Lua package manager

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

      vesktop # Discord Web client with Wayland support
      element-desktop # Matrix chat client

      #######################
      # Media & Entertainment
      #######################

      # Media Applications
      unstable.identity # Image/video comparison tool
      unstable.spotify # Music streaming client
      pinta # Image editor (Paint.NET alternative)

      # Gaming
      unstable.osu-lazer-bin # Rhythm game
      rpcs3 # PS3 emulator
      nix23-11.yuzu-mainline # Nintendo Switch Emulator
      prismlauncher # Minecraft launcher

      #######################
      # Productivity
      #######################

      obsidian # Note taking application

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
