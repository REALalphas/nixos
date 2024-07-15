# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs
, outputs
, lib
, config
, pkgs
, overlay-unstable
, overlay-2311
, ...
}:

{
  imports =
    [
      # Cachix
      ../../cachix/ezkea.nix
      # Include the results of the hardware scan.
      ./system/hardware.nix
      ./system/gnome.nix
    ];
  disabledModules = [ "modules/services/misc/ollama.nix" ];

  nixpkgs = {
    # Enable unstable packages
    overlays = [ overlay-unstable overlay-2311 ];
    # Allow unfree packages
    config.allowUnfree = true;
    config.permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  # Disable nixos documentation
  documentation.nixos.enable = false;

  # environment.variables = {
  #   ROC_ENABLE_PRE_VEGA = "1";
  # };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };
  # hardware.amdgpu.opencl.enable = true;
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
    rocmPackages.rpp-hip
    rocmPackages.hipcc
    rocmPackages.hipblas
    rocmPackages.hipsolver
    rocmPackages.hip-common
    rocmPackages.rocm-comgr
    rocmPackages.rocm-thunk
    rocmPackages.rocm-cmake
    rocmPackages.miopen
    rocmPackages.llvm.llvm
    rocmPackages.llvm.libc
    rocmPackages.llvm.libcxx
    rocmPackages.llvm.libunwind
    rocmPackages.llvm.libcxxabi
    rocmPackages.llvm.compiler-rt
    rocmPackages.llvm.openmp
    # zluda
    amdvlk
  ];
  # Enable HIP system wide
  systemd.tmpfiles.rules = with pkgs; [
    "L+    /opt/rocm/hip   -    -    -     -    ${rocmPackages.clr}"
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nas-2xl"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable experemental flakes feature
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Exclude xterm
  services.xserver.excludePackages = [ pkgs.xterm ];
  # services.xserver.videoDrivers = [ "amdgpu" ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable Bluetooth
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # Enable flatpak
  services.flatpak.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alphas = {
    isNormalUser = true;
    description = "AlphaS";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [

    ];
  };
  users.users.kaktus = {
    isNormalUser = true;
    description = "Kaktus";
    extraGroups = [ "networkmanager" ];
    packages = with pkgs; [

    ];
  };

  # Gaming mice interface
  services.ratbagd.enable = true;

  # Mount web-2xl NFS share
  services.rpcbind.enable = true; # needed for NFS
  systemd.mounts = [{
    type = "nfs";
    mountConfig = {
      Options = "noatime";
    };
    what = "web-2xl:/mnt/M1/user/alphas";
    where = "/mnt/web-2xl/alphas";
  }];

  systemd.automounts = [{
    wantedBy = [ "multi-user.target" ];
    automountConfig = {
      TimeoutIdleSec = "600";
    };
    where = "/mnt/web-2xl/alphas";
  }];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      # MS fonts
      corefonts
      times-newer-roman
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
