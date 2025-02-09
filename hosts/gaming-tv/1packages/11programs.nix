{ config, ... }:
{
  imports = [
    ./11programs/browser.nix
    ./11programs/gaming.nix
    ./11programs/development.nix
    ./11programs/compatibility.nix
  ];
}
