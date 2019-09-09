{ config, pkgs, stdenv, ... }: {
  environment.systemPackages = with pkgs; [
    emacs
    ripgrep
    firefox
    silver-searcher
    slstatus
    slock
    pamixer
  ];
}
