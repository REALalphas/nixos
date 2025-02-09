{ config
, pkgs
, ...
}:
{
  # GTK Theme
  gtk = {
    enable = true;

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    # cursorTheme = {
    #   name = "WhiteSur-cursors";
    #   package = pkgs.unstable.whitesur-cursors;
    # };

    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };

    gtk4.extraConfig.Settings = ''
      gtk-application-prefer-dark-theme=1
    '';
  };

  # QT Theme
  qt = {
    enable = true;

    platformTheme.name = "adwaita";

    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface".color-scheme = "prefer-dark";
    # ...
    # "org/gnome/shell" = {
    #   favorite-apps = [
    #     "firefox.desktop"
    #     "code.desktop"
    #     "org.gnome.Terminal.desktop"
    #     "spotify.desktop"
    #     "virt-manager.desktop"
    #     "org.gnome.Nautilus.desktop"
    #   ];
    # };
    # "org/gnome/desktop/interface" = {
    #   color-scheme = "prefer-dark";
    #   # enable-hot-corners = false;
    # };
    # "org/gnome/desktop/wm/preferences" = {
    #   workspace-names = [ "Main" ];
    # };
    # "org/gnome/desktop/background" = {
    #   picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-l.png";
    #   picture-uri-dark = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-d.png";
    # };
    # "org/gnome/desktop/screensaver" = {
    #   picture-uri = "file:///run/current-system/sw/share/backgrounds/gnome/vnc-d.png";
    #   primary-color = "#3465a4";
    #   secondary-color = "#000000";
    # };
  };
}
