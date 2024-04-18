sudo rm -rf /etc/nixos/
cd /etc/nixos

sudo nix flake init --extra-experimental-features 'nix-command flakes'
sudo nixos-rebuild switch --upgrade --flake /etc/nixos --show-trace