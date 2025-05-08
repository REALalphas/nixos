{
  pkgs,
  ...
}:
{
  home.packages =
    ### GNOME Extensions
    (
      with pkgs.gnomeExtensions;
      [
        # Tray icons
        appindicator
        # Shell blur
        blur-my-shell
        # Connector for phone
        gsconnect
        # Hides bar to allow waydroid full screen
        hide-top-bar
        # Don't show overview on start
        no-overview

      ]
    );
  # Enabled extensions
  dconf.settings."org/gnome/shell" = {
    disable-user-extensions = false;
    enabled-extensions = with pkgs.gnomeExtensions; [
      blur-my-shell.extensionUuid
      gsconnect.extensionUuid
      appindicator.extensionUuid
      hide-top-bar.extensionUuid
      no-overview.extensionUuid
    ];
  };
}
