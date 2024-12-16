{ config, pkgs, lib, ... }:

let
  userList = [
    { name = "alphas"; description = "AlphaS"; groups = [ "networkmanager" "wheel" "libvirtd" "adbusers" "video" "kvm" ]; }
  ];

  users = builtins.listToAttrs (map
    (user: lib.nameValuePair user.name {
      isNormalUser = true;
      description = user.description;
      extraGroups = user.groups;
    })
    userList);

in
{
  users.users = users;
}
