{
  lib,
  pkgs,
  overlays,
  ...
}:
{
  imports = [
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
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.excludePackages = with pkgs; [
    # Simple terminal
    xterm
  ];
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # Excluded apps from gnome installation
  environment.gnome.excludePackages = (
    with pkgs;
    [
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
    ]
  );

  # KVM Support
  virtualisation.libvirtd = {
    enable = true;
    qemu.package = pkgs.qemu_kvm;
    # GPU Passthrough
    qemu.ovmf.enable = true;
  };
  virtualisation.spiceUSBRedirection.enable = true;
  # Virt Manager
  programs.virt-manager.enable = true;

  # Podman Support
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # Waydroid Support
  virtualisation.waydroid.enable = true;

  # Add session variables
  environment.sessionVariables = {
    # QT Adwaita theme # See 12packages.nix
    QT_WAYLAND_DECORATION = "adwaita";
    QT_QPA_PLATFORMTHEME = "gnome";
    QT_STYLE_OVERRIDE = "adwaita-dark";
    # GStreamer, nautilus fix (File properties)
    GST_PLUGIN_SYSTEM_PATH_1_0 = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (
      with pkgs.gst_all_1;
      [
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ]
    );
  };

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    rocmSupport = true;
    permittedInsecurePackages = [
      "dotnet-runtime-wrapped-6.0.36"
      "dotnet-runtime-6.0.36"
      "dotnet-sdk-wrapped-6.0.428"
      "dotnet-sdk-6.0.428"
      "beekeeper-studio-5.1.5"
    ];
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.overlays = overlays;

  # Disable nixos documentation
  documentation.nixos.enable = false;

  # !!! See /flake.nix
  # system.stateVersion = "24.05";
}
