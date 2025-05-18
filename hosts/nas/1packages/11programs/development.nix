{
  pkgs,
  ...
}:
{
  # Android Debug Bridge
  programs.adb.enable = true;

  # Gnome Buider
  # Creating apps
  environment.systemPackages = (
    with pkgs;
    [
      gnome-builder
      flatpak-builder
    ]
  );
}
