#!/bin/sh

sudo mount -o remount,size=10G,noatime /nix/.rw-store
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount ./disk-config_ef00.nix 
sudo nixos-generate-config --root /mnt
sudo rm /mnt/etc/nixos/configuration.nix
sudo cp configuration.nix /mnt/etc/nixos/configuration.nix
sudo cp home.nix /mnt/etc/nixos/home.nix
sudo cp flake.nix /mnt/etc/nixos/flake.nix
sudo nixos-install