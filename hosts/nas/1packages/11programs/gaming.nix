{
  pkgs,
  ...
}:
{
  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  # Gamescope session
  programs.gamescope = {
    package = pkgs.unstable.gamescope;
    enable = true;
    capSysNice = true;
  };

  # aagl-gtk-on-nix
  programs.anime-game-launcher.enable = true; # Adds launcher and /etc/hosts rules
  programs.sleepy-launcher.enable = true; # ZZZ
  # programs.anime-games-launcher.enable = true;
  # programs.anime-borb-launcher.enable = true;
  # programs.honkers-railway-launcher.enable = true;
  # programs.honkers-launcher.enable = true;
  # programs.wavey-launcher.enable = true;
}
