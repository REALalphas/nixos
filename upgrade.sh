sudo rm -rf /etc/nixos/
sudo cp -r --copy-contents ./ /etc/nixos/

cd /etc/nixos
sudo nix flake update --experimental-features 'nix-command flakes'
sudo nixos-rebuild switch --upgrade --flake /etc/nixos --show-trace --experimental-features 'nix-command flakes'