# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "AlphaS";
    userEmail = "ar.su0104@gmail.com";
  };

  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    extensions = with pkgs.unstable.vscode-extensions; [
      pkief.material-product-icons
      # Language support
      bbenoist.nix
      # Formatter
      jnoortheen.nix-ide
    ] ++ pkgs.unstable.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "beardedtheme";
        publisher = "BeardedBear";
        version = "9.1.4";
        sha256 = "44be98928d2eb2d9bfe04af2fc96cd39a65489082f49bbd0bdde129907fca163";
      }
      {
        name = "gruvbox-material-icon-theme";
        publisher = "JonathanHarty";
        version = "1.1.5";
        sha256 = "f3a51652e58a4fa69dc78870e0e270ddc499c5664a2c7e2e2d33be4ac83be606";
      }
    ];

    userSettings = {
      # General settings
      "window.zoomLevel" = 1;
      "security.workspace.trust.enabled" = false;
      "files.autoSave" = "afterDelay";
      # Workbench settings
      "workbench.colorTheme" = "Bearded Theme Black & Amethyst";
      "workbench.iconTheme" = "gruvbox-material-icon-theme";
      "workbench.productIconTheme" = "material-product-icons";
      "workbench.tree.renderIndentGuides" = "always";
      "workbench.tree.indent" = 18;
      "editor.formatOnSave" = true;
      # Editor settings
      "editor.smoothScrolling" = true;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.fontFamily" = "'Fira Code', 'Droid Sans Mono', monospace";
      "editor.fontLigatures" = true;
      # Terminal settings
      "terminal.integrated.smoothScrolling" = true;
      "terminal.integrated.scrollback" = 3000;
      # Git settings
      "git.autofetch" = true;
    };
  };

  home.packages = with pkgs; [
    # osu!lazer
    # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    unstable.osu-lazer-bin

    gnome-frog

    # Vivaldi
    unstable.vivaldi
    unstable.vivaldi-ffmpeg-codecs

    # Tor Browser
    unstable.tor-browser

    # Floorp
    # unstable.floorp
    vdhcoapp

    # Firefox
    firefox-devedition

    # qBittorrent
    qbittorrent

    # Moonlight (client for straming)
    # moonlight-qt

    # Wine
    wine64
    winetricks

    # Node.js for development
    nodejs
    # Bun
    bun

    # Discord + Vencord and OpenASAR
    (discord.override {
      # withOpenASAR = true;
      # withVencord = true;
    })

    # Obsidian
    obsidian

    unstable.prismlauncher

    # Editor
    # unstable.zed-editor

    # Util for monitoring usage of amdgpu
    amdgpu_top

    blender-hip

    # OBS Studio and plugins
    unstable.obs-studio
    obs-studio-plugins.obs-vaapi

    # KeePassXC (Password manager)
    keepassxc
    # Reminna (SSH + RD Client)
    remmina
    # JSTest (Gamepad and 'xinput' tester)
    jstest-gtk
    # Ventoy cli installer
    ventoy-full
    # Piper (Mouse settings editor)
    piper

    pitivi

    unstable.gnome-builder
    unstable.flatpak-builder

    # Warp Terminal
    # unstable.warp-terminal

    # Yuzu Nintendo Switch Emulator
    nixpkgs2311.yuzu-mainline

    # ALVR
    unstable.alvr

    # Android Tools and Scrcpy
    android-tools
    scrcpy

    # moonlight-qt

    # Pipewire stuff
    unstable.easyeffects
    helvum
  ];
}
