{ config
, pkgs
, ...
}:
{
  # Firefox
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;
  };

  # Nix-ld (run unpatched dynamic binaries)
  programs.nix-ld.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # aagl-gtk-on-nix
  programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
  programs.sleepy-launcher.enable = true; # ZZZ
  # programs.anime-games-launcher.enable = true;
  # programs.anime-borb-launcher.enable = true;
  # programs.honkers-railway-launcher.enable = true;
  # programs.honkers-launcher.enable = true;
  # programs.wavey-launcher.enable = true;

  # Android Debug Bridge
  programs.adb.enable = true;
}
