{ config
, lib
, pkgs
, modulesPath
, overlays
, ...
}:
{
  imports =
    [
      ./0system/0hardware.nix
      ./0system/1boot.nix
      ./0system/2filesystem.nix
      ./0system/3locale.nix
      ./0system/4network.nix
      ./0system/5systemd.nix
      ./0system/6audio.nix

      ./1packages/10services.nix
      ./1packages/11programs.nix
      ./1packages/12packages.nix
      ./1packages/13fonts.nix

      ./2home/20users.nix
    ];

  ## GNOME DE
  # Enable the X11 windowing system. (Also wayland)
  services.xserver.enable = true;
  services.xserver.excludePackages = with pkgs; [
    # Simple terminal
    pkgs.xterm
  ];
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Excluded apps from gnome installation
  environment.gnome.excludePackages = (with pkgs; [
    # Photos app
    gnome-photos
    # Welcome tour
    gnome-tour
    # Camera app
    # snapshot
    # Gnome password manager
    gnome-secrets
    # VNC/RDP Client
    gnome-connections
    # Browser
    epiphany
  ]) ++ (with pkgs.gnome; [
    # Maps app
    gnome-maps
    # Contacts list
    gnome-contacts
    # Music player
    gnome-music
    # Simple scan
    simple-scan
    # Video player
    totem
    # Camera app (old)
    cheese
    # Gnome password manager and encryption keys
    seahorse
    # Help app
    # yelp
  ]);

  # KVM Support
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.package = pkgs.qemu_kvm;

  # Add session variables
  environment.sessionVariables = {
    GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
      (with pkgs.gst_all_1; [
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ]);
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.rocmSupport = true;
  nixpkgs.config.android_sdk.accept_license = true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.overlays = overlays;

  # Disable nixos documentation
  documentation.nixos.enable = false;

  # !!! See /flake.nix
  # system.stateVersion = "24.05";
}
