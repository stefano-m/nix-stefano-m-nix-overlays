{pkgs ? import <nixpkgs> {}}:

with pkgs;

{

  connman_dbus      = callPackage ./connman_dbus {};

  connman_widget    = callPackage ./connman_widget {};

  dbus_proxy        = callPackage ./dbus_proxy {};

  enum              = callPackage ./enum {};

  media_player      = callPackage ./media_player {};

  power_widget      = callPackage ./power_widget {};

  pulseaudio_dbus   = callPackage ./pulseaudio_dbus {};

  pulseaudio_widget = callPackage ./pulseaudio_widget {};

  upower_dbus       = callPackage ./upower_dbus {};

}
