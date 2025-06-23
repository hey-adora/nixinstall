# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;

  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "b650";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver.enable = true;
  services.xserver.desktopManager.plasma6.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

  services.pipewire.enable = true;
  services.pipewire.pulse.enable = true;
  services.pipewire.alsa.enable = true;
  services.pipewire.alsa.support32Bit = true;
  services.pipewire.jack.enable = true;

  services.libinput.enable = true;

  programs.zsh.enable = true;

  users.groups.libvirtd.members = [ "hey" ];
  virtualisation.libvirtd.enable = true;

  users.users.lyndonm = {
    initialPassword = "home";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      #home-manager
    ];
  };

  environment.systemPackages = with pkgs; [
    zsh
  ];

  system.stateVersion = "25.11"; # Did you read the comment?

}
