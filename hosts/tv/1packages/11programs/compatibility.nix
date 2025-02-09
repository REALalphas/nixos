{ config, options, pkgs, ... }:
{
  # Nix-ld (run unpatched dynamic binaries)
  # programs.nix-ld.enable = true;
  # programs.nix-ld.libraries = options.programs.nix-ld.libraries.default ++ (with pkgs; [
  #   # electron
  #   alsa-lib.out
  #   at-spi2-atk.out
  #   cairo.out
  #   cups.lib
  #   dbus.lib
  #   libdrm.out
  #   expat.out
  #   mesa.out
  #   gdk-pixbuf.out
  #   glib.out
  #   gtk3.out
  #   nspr.out
  #   nss.out
  #   pango.out
  #   systemd.out
  #   xorg.libX11.out
  #   xorg.libxcb.out
  #   xorg.libXcomposite.out
  #   xorg.libXdamage.out
  #   xorg.libXext.out
  #   xorg.libXfixes.out
  #   libxkbcommon.out
  #   xorg.libXrandr.out
  #   libGL.out

  #   # node-gyp - node-gtk
  #   gobject-introspection
  #   cairo
  #   pkg-config
  # ]);
}
