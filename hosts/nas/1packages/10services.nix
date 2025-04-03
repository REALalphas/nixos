{
  config,
  pkgs,
  ...
}:
{
  # Disable CUPS to print documents.
  services.printing.enable = false;

  # Open WebUI Ollama web wrapper
  # services.open-webui.package = pkgs.open-webui;
  # services.open-webui.enable = true;
  # services.open-webui.environment = {
  #   ANONYMIZED_TELEMETRY = "False";
  #   DO_NOT_TRACK = "True";
  #   SCARF_NO_ANALYTICS = "True";
  #   # WEBUI_AUTH = "False";
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Enable RPC Daemon for NFS Shares # See 5systemd.nix # See 12packages.nix
  services.rpcbind.enable = true;

  # Duplicati service for Backups
  services.duplicati.enable = true; # Port 8200 (http://127.0.0.1:8200)
  services.duplicati.user = "alphas"; # Run only for user you want to backup, run as root at you risk

  # Packages udev (rules)
  services.udev.packages = with pkgs; [ gnome-settings-daemon ];

  # Whether to enable ollama server for local large language models. # See alphas/packages.nix
  services.ollama = {
    package = pkgs.unstable.ollama-rocm;
    enable = true;
    host = "0.0.0.0";
    acceleration = "rocm";
    openFirewall = true;
    environmentVariables = {
      HCC_AMDGPU_TARGET = "gfx1101";
    };
    rocmOverrideGfx = "11.0.1";
  };

  # Jellyfin (Home Media Server) # See 12packages.nix
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "alphas";
  };
}
