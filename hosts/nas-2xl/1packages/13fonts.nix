{ config
, pkgs
, ...
}:
{
  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      # MS fonts
      # corefonts
      # times-newer-roman
    ];
  };

}
