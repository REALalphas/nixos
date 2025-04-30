{ config, pkgs, ... }:

let
  enableXServer = false; # или false
in

{
  # services.xserver.enable = enableXServer;
  # services.xserver.excludePackages = with pkgs; [
  #   # Simple terminal
  #   pkgs.xterm
  # ];
}
