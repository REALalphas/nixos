{
  inputs,
  config,
  pkgs,
  ...
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
      "org.gnome.Geary.desktop"
      "firefox-devedition.desktop"
      "code.desktop"
      "vesktop.desktop"
    ];
    # Add qemu handler for VMs
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  # TODO: See flake.nix
  home.stateVersion = "24.11";
  home.enableNixpkgsReleaseCheck = false;

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
