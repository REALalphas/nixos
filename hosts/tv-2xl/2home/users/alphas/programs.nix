{ inputs
, pkgs
, ...
}:
{
  # Git
  programs.git = {
    enable = true;
    userName = "AlphaS";
    userEmail = "ar.su0104@gmail.com";
  };

  # Visual Studio Code
  programs.vscode = {
    enable = true;
    # Disable update check
    enableUpdateCheck = false;
    # Enable extensions update check
    enableExtensionUpdateCheck = true;

    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      pkief.material-product-icons
      # Language support
      bbenoist.nix
      # Formatter # See packages.nix
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
    ];

    userSettings = {
      # General settings
      "window.zoomLevel" = 0.8;
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
      "editor.fontSize" = 14;
      "editor.fontLigatures" = true;
      # Terminal settings
      "terminal.integrated.smoothScrolling" = true;
      "terminal.integrated.scrollback" = 3000;
      "terminal.integrated.fontSize" = 11;
      # Git settings
      "git.autofetch" = true;
      # Make non native
      "window.titleBarStyle" = "custom";
    };
  };
}
