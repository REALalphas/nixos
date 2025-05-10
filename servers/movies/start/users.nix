{
  pkgs,
  ...
}:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alphas = {
    isNormalUser = true;
    extraGroups = [ "wheel" "podman" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.bash;
  };
}
