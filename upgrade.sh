sudo rm -rf /etc/nixos/
sudo cp -r --copy-contents ./ /etc/nixos/

cd /etc/nixos
sudo nix flake init --experimental-features 'nix-command flakes'
sudo nix flake update
sudo nixos-rebuild switch --upgrade --flake /etc/nixos --show-trace