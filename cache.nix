{
  ...
}:

{
  # Add cache
  nix.settings = {
    substituters = [
      # nix-gaming
      "https://nix-gaming.cachix.org"
      # aagl-gtk-on-nix
      "https://ezkea.cachix.org"
    ];
    trusted-public-keys = [
      # nix-gaming
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      # aagl-gtk-on-nix
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };
}
