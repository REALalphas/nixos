{
  stateVersion,
  ...
}:
let
  # Getting username from foldet it's in
  username = builtins.baseNameOf (toString ./.);
in
{
  imports = [
    ./packages.nix
    ./programs.nix
    ./style.nix
  ];

  # !!! See /flake.nix
  home.stateVersion = stateVersion;
  home.enableNixpkgsReleaseCheck = false;

  home.username = "${username}";
  home.homeDirectory = "/home/${username}";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;

  dconf.settings = {
    # Mouse acceliration ["default", "flat", "adaptive"]
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    # Titlebar actions and placement
    "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,close";
    # Hot Corner
    "org/gnome/desktop/interface".enable-hot-corners = true;
    # Edge tiling (Active Screen Edges)
    "org/gnome/mutter".edge-tiling = true;
    # Favorite apps (Dash pinned apps)
    "org/gnome/shell".favorite-apps = [
      "org.gnome.Nautilus.desktop"
      "org.gnome.Console.desktop"
      "firefox-devedition.desktop"
      "code.desktop"
      "vesktop.desktop"
      "spotify.desktop"
    ];
    # Add qemu handler for VMs
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
    # Volume Step Settings
    "org/gnome/settings-daemon/plugins/media-keys".volume-step = 5;
  };
}
