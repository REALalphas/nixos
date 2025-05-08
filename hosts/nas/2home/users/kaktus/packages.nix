{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    firefox
    # Add user's packages
  ];
}
