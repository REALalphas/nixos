{ inputs
, config
, pkgs
, ...
}:
let
  username = "alphas";
in
{
  imports = [
    # inputs.spicetify-nix.homeManagerModules.default

    ./packages.nix
    ./programs.nix
    ./style.nix
  ];

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.11";
  home.enableNixpkgsReleaseCheck = false;

  dconf.settings = {
    # Mouse acceliration ["default", "flat", "adaptive"]
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    # Titlebar actions and placement
    "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,close";
    # Font for titlebar
    "org/gnome/desktop/wm/preferences".titlebar-font = "Noto Sans Bold 11";

    # Hot Corner
    "org/gnome/desktop/interface".enable-hot-corners = true;
    # Edge tiling (Active Screen Edges)
    "org/gnome/mutter".edge-tiling = false;

    # Favorite apps (Dash pinned apps)
    # "org/gnome/shell".favorite-apps = [
    #   "org.gnome.Nautilus.desktop"
    #   "org.gnome.Console.desktop"
    #   "org.gnome.Geary.desktop"
    #   "firefox-devedition.desktop"
    #   "code.desktop"
    #   "vesktop.desktop"
    # ];

    # Enabled extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        blur-my-shell.extensionUuid
        gsconnect.extensionUuid
        appindicator.extensionUuid
      ];
    };
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}