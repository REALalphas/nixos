{ config
, pkgs
, ...
}:
{
  # !!! List packages installed in SYSTEM
  # To search run: `$ nix search wget`
  environment.systemPackages = (with pkgs; [

    # Text editor (cli)
    nano

    # NFS Support # See 5systemd.nix # See 10services.nix
    nfs-utils

    ## Gnome Extensions
  ]) ++ (with pkgs.gnomeExtensions; [
    # Tray icons
    appindicator
    # Shell blur
    blur-my-shell
    gsconnect

    # Shell blur
    # gnomeExtensions.blur-my-shell
    # FIXME: Geminiai
    # gnomeExtensions.gemini-ai
  ]);

}
