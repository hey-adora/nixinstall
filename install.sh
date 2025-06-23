#!/bin/sh

sudo mount -o remount,size=10G,noatime /nix/.rw-store
nixos-generate-config --root . --no-filesystems
sudo nix --experimental-features "nix-command flakes" run 'github:nix-community/disko/latest#disko-install' --  --flake '.#b650'