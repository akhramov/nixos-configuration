{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./packages.nix
      ./desktop.nix
    ];

  boot.loader.systemd-boot.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Omsk";

  hardware.pulseaudio.package = pkgs.pulseaudio.override {
    jackaudioSupport = true;
  };

  sound.enable = true;
  sound.mediaKeys.enable = true;

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      # Backlight
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }

      # Media keys
      { keys = [ 121 ]; events = [ "key" ];       command = "/run/current-system/sw/bin/amixer -q set Master toggle"; }
      { keys = [ 122 ]; events = [ "key" "rep" ]; command = "/run/current-system/sw/bin/amixer -q set Master 10- unmute"; }
      { keys = [ 123 ]; events = [ "key" "rep" ]; command = "/run/current-system/sw/bin/amixer -q set Master 10+ unmute"; }
      { keys = [ 198 ]; events = [ "key" ];       command = "/run/current-system/sw/bin/amixer -q set Capture toggle"; }
    ];
  };

  services.davfs2.enable = true;

  users.users.akhramov = {
     isNormalUser = true;
     extraGroups = [ "wheel" "vboxusers" "davfs2" ];
  };

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  nixpkgs.config.virtualbox.host.enableExtensionPack = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?
}
