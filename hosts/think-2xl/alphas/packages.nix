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
    extensions = with pkgs.vscode-extensions; [
      pkief.material-product-icons
      jnoortheen.nix-ide
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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
      {
        name = "aw-watcher-vscode";
        publisher = "lindraupe";
        version = "0.4.1";
        sha256 = "0be0b6b52a13dbee26470cad2a6afc3adee8e5f8e0f98c5272c1831785309af2";
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
      # "terminal.integrated.smoothScrolling" = true;
      "terminal.integrated.scrollback" = 3000;
      # Git settings
      "git.autofetch" = true;
    };
  };

  home.packages = with pkgs; [
    # osu!lazer
    # inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    unstable.osu-lazer-bin

    # Pipewire stuff
    unstable.easyeffects
    helvum

    gnome-frog

    # Vivaldi
    unstable.vivaldi
    unstable.vivaldi-ffmpeg-codecs

    # qBittorrent
    qbittorrent

    # Moonlight (client for straming)
    moonlight-qt

    # Wine
    wine64
    winetricks

    # Node.js for development
    nodejs_21
    # Bun
    bun

    # Discord + Vencord and OpenASAR
    (discord.override {
      # withOpenASAR = true;
      withVencord = true;
    })

    # Obsidian
    obsidian

    unstable.prismlauncher

    # Editor
    #unstable.zed-editor
  ];
}
