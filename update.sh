sudo cp -r --copy-contents ./ /etc/nixos/

cd /etc/nixos
sudo nix flake update
sudo nixos-rebuild switch --flake /etc/nixos