{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./style.nix
  ];

  home.username = "alphas";
  home.homeDirectory = "/home/alphas";
  dconf.settings = {
    # Mouse acceliration ["default", "flat", "adaptive"]
    "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
    # Icons in titlebar
    "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,close";
    # Font for titlebar
    "org/gnome/desktop/wm/preferences".titlebar-font = "Cantarell Bold 11";

    # Add qemu handler for VMs
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };



  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
