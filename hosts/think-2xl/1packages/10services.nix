{ config
, pkgs
, ...
}:
{
  # Enable CUPS to print documents.
  # services.printing.enable = true;

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
}
