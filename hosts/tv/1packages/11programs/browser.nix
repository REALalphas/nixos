{
  pkgs,
  ...
}:
{
  # Firefox
  programs.firefox = {
    enable = true;
    package = pkgs.unstable.firefox-devedition-bin;
  };

  # Ladybird Browser (Fork from SerenityOS)
  programs.ladybird.enable = true;
}
