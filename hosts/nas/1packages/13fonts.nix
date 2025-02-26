{
  config,
  pkgs,
  ...
}:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      manrope
      departure-mono
      # MS fonts
      # corefonts
      # times-newer-roman
    ];
  };

}
