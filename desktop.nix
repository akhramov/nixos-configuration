{ config, pkgs, stdenv, ... }:
{
  nixpkgs.config = {
    dwm.patches = [
      ./desktop/dwm/patch.diff
    ];

    slstatus.conf =
      builtins.readFile ./desktop/slstatus/config.def.h;
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us,ru";
  services.xserver.xkbOptions = "grp:alt_space_toggle";
  services.xserver.xkbVariant = "mac,mac";

  # Enable touchpad support.
  services.xserver.libinput.enable = true;
  services.xserver.libinput.tapping = false;

  services.xserver.windowManager.dwm.enable = true;

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge <<EOF
      Xft.dpi: 144
      Xcursor.theme: Adwaita
      Xcursor.size: 64
    EOF

    slstatus &
  '';


  services.xserver.xautolock = {
    enable = true;
    time = 5;
  };

  security.wrappers.slock.source = "${pkgs.slock.out}/bin/slock";
}
