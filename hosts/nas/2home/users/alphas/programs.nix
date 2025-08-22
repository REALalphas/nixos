{
  pkgs,
  ...
}:
{
  # Git
  programs.git = {
    enable = true;
    userName = "AlphaS";
    userEmail = "ar.su0104@gmail.com";
  };

  # Visual Studio Code
  programs.vscode.profiles.default.extensions =
    with pkgs.vscode-extensions;
    [
      pkief.material-product-icons
      # Language support
      bbenoist.nix
      # Formatter # See packages.nix
      jnoortheen.nix-ide
    ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
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

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
  };

  # Spotify with mods
  # programs.spicetify =
  #   let
  #     spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  #   in
  #   {
  #     enable = true;
  #     theme = {
  #       name = "Override";

  #       src = spicePkgs.themes.spotifyNoPremium.src;
  #       requiredExtensions = [ spicePkgs.extensions.adblock ];

  #       injectCss = true;
  #       replaceColors = false;
  #       sidebarConfig = false;
  #       # homeConfig = true;
  #       overwriteAssets = true;
  #       additionalCss = ''
  #         * {
  #         box-shadow: 0 0 1px solid #fff;
  #         }
  #       '';
  #     };

  #     enabledExtensions = with spicePkgs.extensions; [
  #       adblock
  #       betterGenres
  #       history
  #       shuffle
  #       songStats
  #       hidePodcasts
  #     ];
  #   };
}
