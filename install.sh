#!/bin/sh

sudo mount -o remount,size=10G,noatime /nix/.rw-store
nixos-generate-config --root . --no-filesystems
cp ./etc/nixos/hardware-configuration.nix hardware-configuration.nix
rm ./etc/nixos/configuration.nix 
rm ./etc/nixos/hardware-configuration.nix
rmdir ./etc/nixos
rmdir ./etc
sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' --  --flake '.#b650'